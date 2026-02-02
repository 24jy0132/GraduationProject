package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Types;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import model.Reservation;
import service.Constants;

public class ReservationDao {

	private static final String URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant?characterEncoding=UTF-8";
	private static final String USER = "root";
	private static final String PASS = "shadowseeker";

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private Connection getConn() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASS);
	}

	// =========================
	// AUTO ASSIGN TABLE
	// =========================
	public List<String> assignTables(LocalDate date, LocalTime start, int totalPeople) throws SQLException {
		LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);
		String[] candidates = totalPeople <= 2 ? new String[] { "A1", "A2" }
				: totalPeople <= 4 ? new String[] { "T1", "T2", "T3", "T4" } : new String[] { "Z1", "Z2", "Z3", "Z4" };

		List<String> result = new ArrayList<>();
		for (String table : candidates) {
			if (isTableAvailable(date, start, end, table)) {
				result.add(table);
				break;
			}
		}
		return result;
	}

	// =========================
	// CHECK AVAILABILITY
	// =========================
	public boolean areTablesAvailable(LocalDate date, LocalTime start, LocalTime end, String[] tableIds)
			throws SQLException {
		String sql = "SELECT COUNT(*) FROM reservation_table rt " +
				"JOIN reservations r ON rt.reservationId = r.reservationId " +
				"WHERE rt.table_id = ? AND r.reservationDate = ? AND r.startTime < ? AND r.endTime > ?";

		try (Connection con = getConn(); PreparedStatement ps = con.prepareStatement(sql)) {
			for (String tableId : tableIds) {
				ps.setString(1, tableId);
				ps.setDate(2, Date.valueOf(date));
				ps.setTime(3, Time.valueOf(end));
				ps.setTime(4, Time.valueOf(start));
				ResultSet rs = ps.executeQuery();
				rs.next();
				if (rs.getInt(1) > 0)
					return false;
			}
		}
		return true;
	}

	private void validateFutureReservation(LocalDate date, LocalTime startTime) throws SQLException {
		LocalDate today = LocalDate.now();
		LocalTime now = LocalTime.now();
		if (date.isBefore(today))
			throw new SQLException("過去の日付は予約できません");
		if (date.isEqual(today) && !startTime.isAfter(now))
			throw new SQLException("現在時刻より前の時間は予約できません");
	}

	public boolean isTableAvailable(LocalDate date, LocalTime start, LocalTime end, String tableId)
			throws SQLException {
		String sql = "SELECT COUNT(*) FROM reservations r JOIN reservation_table rt ON r.reservationId = rt.reservationId "
				+
				"WHERE r.reservationDate = ? AND rt.table_id = ? AND r.startTime < ? AND r.endTime > ? AND r.status IN ('RESERVED', 'CONFIRMED')";

		try (Connection con = getConn(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setDate(1, Date.valueOf(date));
			ps.setString(2, tableId);
			ps.setTime(3, Time.valueOf(end));
			ps.setTime(4, Time.valueOf(start));
			ResultSet rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1) == 0;
		}
	}

	// =========================
	// INSERT RESERVATION (MAIN)
	// =========================
	public void insertCustomerReservation(Reservation r) throws SQLException {
		validateFutureReservation(r.getReservationDate(), r.getStartTime());
		Connection con = getConn();

		try {
			con.setAutoCommit(false);

			// 1. Lock check
			String lockSql = "SELECT 1 FROM reservation_table rt JOIN reservations r ON r.reservationId = rt.reservationId "
					+
					"WHERE rt.table_id = ? AND r.reservationDate = ? AND r.startTime < ? AND r.endTime > ? AND r.status NOT IN ('FINISHED','CANCELLED') FOR UPDATE";

			try (PreparedStatement lockPs = con.prepareStatement(lockSql)) {
				for (String tableId : r.getTableIds()) {
					lockPs.setString(1, tableId);
					lockPs.setDate(2, Date.valueOf(r.getReservationDate()));
					lockPs.setTime(3, Time.valueOf(r.getStartTime()));
					lockPs.setTime(4, Time.valueOf(r.getEndTime()));

					try (ResultSet rs = lockPs.executeQuery()) {
						if (rs.next())
							throw new SQLException("選択した席は既に予約されています");
					}
				}
			}

			// 2. Insert Reservation (Includes customer_phone)
			String insertReservationSql = "INSERT INTO reservations " +
					"(customerId, reservationDate, startTime, endTime, adultCount, childCount, " +
					"reservationType, courseId, couponId, customerEmail, customer_name, customer_phone, status) " +
					"VALUES (?,?,?,?,?,?,?,?,?,?,?,?, 'RESERVED')";

			int reservationId;

			try (PreparedStatement ps = con.prepareStatement(insertReservationSql, Statement.RETURN_GENERATED_KEYS)) {
				if (r.getCustomerId() != null)
					ps.setInt(1, r.getCustomerId());
				else
					ps.setNull(1, Types.INTEGER);

				ps.setDate(2, Date.valueOf(r.getReservationDate()));
				ps.setTime(3, Time.valueOf(r.getStartTime()));
				ps.setTime(4, Time.valueOf(r.getEndTime()));
				ps.setInt(5, r.getAdultCount());
				ps.setInt(6, r.getChildCount());
				ps.setString(7, r.getReservationType());

				if (r.getCourseId() != null)
					ps.setInt(8, r.getCourseId());
				else
					ps.setNull(8, Types.INTEGER);
				if (r.getCouponId() != null && r.getCouponId() != 0)
					ps.setInt(9, r.getCouponId());
				else
					ps.setNull(9, Types.INTEGER);

				ps.setString(10, r.getCustomerEmail());
				ps.setString(11, r.getCustomerName());
				ps.setString(12, r.getCustomerPhone()); // ✅ INSERT PHONE

				ps.executeUpdate();

				try (ResultSet keys = ps.getGeneratedKeys()) {
					if (keys.next()) {
						reservationId = keys.getInt(1);
					} else {
						throw new SQLException("Failed to retrieve reservation ID.");
					}
				}
			}

			// 3. Insert Tables
			String insertTableSql = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?,?)";
			try (PreparedStatement ps = con.prepareStatement(insertTableSql)) {
				for (String tableId : r.getTableIds()) {
					ps.setInt(1, reservationId);
					ps.setString(2, tableId);
					ps.addBatch();
				}
				ps.executeBatch();
			}

			// 4. Point Deduction
			if (r.getCustomerId() != null && r.getUsedPoint() != null && r.getUsedPoint() > 0) {
				String sql = "UPDATE customers SET point = point - ? WHERE userId = ? AND point >= ?";
				try (PreparedStatement ps = con.prepareStatement(sql)) {
					ps.setInt(1, r.getUsedPoint());
					ps.setInt(2, r.getCustomerId());
					ps.setInt(3, r.getUsedPoint());
					if (ps.executeUpdate() == 0)
						throw new SQLException("ポイントが不足しています");
				}
			}

			// 5. Coupon Usage
			if (r.getCouponId() != null && r.getCustomerId() != null) {
				String sql = "INSERT INTO coupon_usage (userId, couponId) VALUES (?, ?)";
				try (PreparedStatement ps = con.prepareStatement(sql)) {
					ps.setInt(1, r.getCustomerId());
					ps.setInt(2, r.getCouponId());
					ps.executeUpdate();
				}
			}

			con.commit();
		} catch (Exception e) {
			if (con != null)
				con.rollback();
			throw e;
		} finally {
			if (con != null) {
				con.setAutoCommit(true);
				con.close();
			}
		}
	}

	// =========================
	// INSERT WITH TABLES (ADMIN/SIMPLE)
	// =========================
	public void insertWithTables(Reservation r) throws SQLException {
		// Includes customer_phone
		String sqlReservation = "INSERT INTO reservations " +
				"(reservationDate,startTime,endTime,adultCount,childCount,customer_name,customerEmail,customer_phone,status) "
				+
				"VALUES (?,?,?,?,?,?,?,?,?)";

		String sqlTable = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?,?)";

		try (Connection con = getConn()) {
			con.setAutoCommit(false);

			try (PreparedStatement ps = con.prepareStatement(sqlReservation, Statement.RETURN_GENERATED_KEYS)) {
				ps.setDate(1, Date.valueOf(r.getReservationDate()));
				ps.setTime(2, Time.valueOf(r.getStartTime()));
				ps.setTime(3, Time.valueOf(r.getEndTime()));
				ps.setInt(4, r.getAdultCount());
				ps.setInt(5, r.getChildCount());
				ps.setString(6, r.getCustomerName());
				ps.setString(7, r.getCustomerEmail());
				ps.setString(8, r.getCustomerPhone()); // ✅ INSERT PHONE
				ps.setString(9, r.getStatus());

				ps.executeUpdate();
				ResultSet rs = ps.getGeneratedKeys();
				rs.next();
				r.setReservationId(rs.getInt(1));
			}

			try (PreparedStatement ps2 = con.prepareStatement(sqlTable)) {
				for (String t : r.getTableIds()) {
					ps2.setInt(1, r.getReservationId());
					ps2.setString(2, t);
					ps2.addBatch();
				}
				ps2.executeBatch();
			}
			con.commit();
		}
	}

	// =========================
	// FIND METHODS
	// =========================
	public List<Reservation> findAll() {
		Map<Integer, Reservation> map = new LinkedHashMap<>();
		String sql = "SELECT r.*, rt.table_id, m.menuName AS courseName, c.title AS couponTitle " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt ON r.reservationId = rt.reservationId " +
				"LEFT JOIN menu m ON r.courseId = m.menuId " +
				"LEFT JOIN coupon c ON r.couponId = c.couponId " +
				"ORDER BY r.reservationDate DESC, r.startTime DESC";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				int id = rs.getInt("reservationId");
				Reservation r = map.get(id);
				if (r == null) {
					r = map(rs);
					r.setTableIds(new ArrayList<>());
					map.put(id, r);
				}
				String tableId = rs.getString("table_id");
				if (tableId != null)
					r.getTableIds().add(tableId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>(map.values());
	}

	// =========================
	// UPDATE (ADMIN)
	// =========================
	public void update(Reservation r) {
		// Includes customer_phone
		String sqlUpdate = "UPDATE reservations SET " +
				"reservationDate=?, startTime=?, endTime=?, " +
				"adultCount=?, childCount=?, customer_name=?, customerEmail=?, customer_phone=? " +
				"WHERE reservationId=?";

		String sqlDeleteTables = "DELETE FROM reservation_table WHERE reservationId=?";
		String sqlInsertTable = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?, ?)";

		try (Connection con = getConn()) {
			con.setAutoCommit(false);

			try (PreparedStatement ps = con.prepareStatement(sqlUpdate)) {
				ps.setDate(1, Date.valueOf(r.getReservationDate()));
				ps.setTime(2, Time.valueOf(r.getStartTime()));
				ps.setTime(3, Time.valueOf(r.getEndTime()));
				ps.setInt(4, r.getAdultCount());
				ps.setInt(5, r.getChildCount());
				ps.setString(6, r.getCustomerName());
				ps.setString(7, r.getCustomerEmail());
				ps.setString(8, r.getCustomerPhone()); // ✅ UPDATE PHONE
				ps.setInt(9, r.getReservationId());
				ps.executeUpdate();
			}

			try (PreparedStatement ps = con.prepareStatement(sqlDeleteTables)) {
				ps.setInt(1, r.getReservationId());
				ps.executeUpdate();
			}

			try (PreparedStatement ps = con.prepareStatement(sqlInsertTable)) {
				for (String tableId : r.getTableIds()) {
					ps.setInt(1, r.getReservationId());
					ps.setString(2, tableId);
					ps.addBatch();
				}
				ps.executeBatch();
			}
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateStatus(int id, String status) {
		String sql = "UPDATE reservations SET status=? WHERE reservationId=?";
		try (Connection con = getConn(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(int reservationId) {
		String sql1 = "DELETE FROM reservation_table WHERE reservationId = ?";
		String sql2 = "DELETE FROM reservations WHERE reservationId = ?";
		try (Connection con = getConn()) {
			con.setAutoCommit(false); // transaction
			try (PreparedStatement ps1 = con.prepareStatement(sql1);
					PreparedStatement ps2 = con.prepareStatement(sql2)) {
				ps1.setInt(1, reservationId);
				ps1.executeUpdate();
				ps2.setInt(1, reservationId);
				ps2.executeUpdate();
				con.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Reservation> findByCustomerId(int customerId) {
		Map<Integer, Reservation> map = new LinkedHashMap<>();
		String sql = "SELECT r.*, rt.table_id " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt " +
				"ON r.reservationId = rt.reservationId " +
				"WHERE r.customerId = ? " +
				"ORDER BY r.reservationDate DESC, r.startTime DESC";
		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, customerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("reservationId");
				Reservation r = map.get(id);
				if (r == null) {
					r = map(rs);
					r.setTableIds(new ArrayList<>());
					map.put(id, r);
				}
				String tableId = rs.getString("table_id");
				if (tableId != null) {
					r.getTableIds().add(tableId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>(map.values());
	}

	public Reservation findById(int id) {
		Reservation r = null;
		String sql = "SELECT r.*, rt.table_id " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt " +
				"ON r.reservationId = rt.reservationId " +
				"WHERE r.reservationId = ?";
		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (r == null) {
					r = map(rs);
					r.setTableIds(new ArrayList<>());
				}
				String tableId = rs.getString("table_id");
				if (tableId != null) {
					r.getTableIds().add(tableId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	// =========================
	// ADMIN: FIND BY DATE LIST (For Scheduler View)
	// =========================
	public List<Reservation> findByDatelist(LocalDate date) {
		Map<Integer, Reservation> map = new LinkedHashMap<>();

		// This query joins necessary tables to get course names and table IDs
		String sql = "SELECT r.*, rt.table_id, m.menuName AS courseName, c.title AS couponTitle " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt ON r.reservationId = rt.reservationId " +
				"LEFT JOIN menu m ON r.courseId = m.menuId " +
				"LEFT JOIN coupon c ON r.couponId = c.couponId " +
				"WHERE r.reservationDate = ? " +
				"ORDER BY r.startTime, rt.table_id";

		try (Connection con = getConn(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setDate(1, Date.valueOf(date));
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("reservationId");
				Reservation r = map.get(id);
				if (r == null) {
					r = map(rs); // Uses your existing map() method
					r.setTableIds(new ArrayList<>());
					map.put(id, r);
				}
				String tableId = rs.getString("table_id");
				if (tableId != null) {
					r.getTableIds().add(tableId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>(map.values());
	}
	
	public boolean requestCheckout(String table_id) {

	    String sql =
	        "UPDATE reservations r " +
	        "JOIN reservation_table rt " +
	        "ON r.reservationId = rt.reservationId " +
	        "SET r.status = ? " +
	        "WHERE rt.table_id = ? " +
	        "AND r.status = 'ARRIVED'";

	    try (Connection con = getConn();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, "BILL_REQUESTED");
	        ps.setString(2, table_id);

	        int result = ps.executeUpdate();

	        return result == 1; // ✅ success if exactly one row updated

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}


	// =========================
	// ADMIN: COUNT BY MONTH (For Calendar Badges)
	// =========================
	public Map<LocalDate, Integer> countByMonth(YearMonth ym) {
		Map<LocalDate, Integer> map = new HashMap<>();

		// Count reservations per day within the selected month range
		String sql = "SELECT reservationDate, COUNT(*) AS cnt " +
				"FROM reservations " +
				"WHERE reservationDate BETWEEN ? AND ? " +
				"GROUP BY reservationDate";

		try (Connection con = getConn(); PreparedStatement ps = con.prepareStatement(sql)) {
			// First day of month
			ps.setDate(1, Date.valueOf(ym.atDay(1)));
			// Last day of month
			ps.setDate(2, Date.valueOf(ym.atEndOfMonth()));

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				map.put(
						rs.getDate("reservationDate").toLocalDate(),
						rs.getInt("cnt"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	// =========================
	// MAPPER
	// =========================
	private Reservation map(ResultSet rs) throws SQLException {
		Reservation r = new Reservation();
		r.setReservationId(rs.getInt("reservationId"));
		r.setReservationDate(rs.getDate("reservationDate").toLocalDate());
		r.setStartTime(rs.getTime("startTime").toLocalTime());
		r.setEndTime(rs.getTime("endTime").toLocalTime());
		r.setCustomerId((Integer) rs.getObject("customerId"));
		r.setCustomerName(rs.getString("customer_name"));
		r.setCustomerEmail(rs.getString("customerEmail"));

		// ✅ MAP PHONE
		try {
			r.setCustomerPhone(rs.getString("customer_phone"));
		} catch (SQLException e) {
			// In case column doesn't exist yet
		}

		r.setAdultCount(rs.getInt("adultCount"));
		r.setChildCount(rs.getInt("childCount"));
		r.setStatus(rs.getString("status"));

		try {
			r.setCourseName(rs.getString("courseName"));
		} catch (SQLException ignore) {
		}
		try {
			r.setCouponTitle(rs.getString("couponTitle"));
		} catch (SQLException ignore) {
		}

		return r;
	}
}