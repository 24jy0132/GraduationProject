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

	private static final String URL = "jdbc:mysql://10.64.144.5:3306/24jy0234?characterEncoding=UTF-8";

	private static final String USER = "24jy0234";
	private static final String PASS = "24jy0234";

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // ✅ correct driver
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
	public List<String> assignTables(
			LocalDate date,
			LocalTime start,
			int totalPeople) throws SQLException {

		LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);

		String[] candidates = totalPeople <= 2 ? new String[] { "A1", "A2" }
				: totalPeople <= 4 ? new String[] { "T1", "T2", "T3", "T4" } : new String[] { "Z1", "Z2", "Z3", "Z4" };

		List<String> result = new ArrayList<>();

		for (String table : candidates) {
			if (isTableAvailable(date, start, end, table)) {
				result.add(table);
				break; // customer can choose only ONE table
			}
		}

		return result; // empty = 満席
	}

	public boolean areTablesAvailable(
			LocalDate date,
			LocalTime start,
			LocalTime end,
			String[] tableIds) throws SQLException {

		String sql = "SELECT COUNT(*) " +
				"FROM reservation_table rt " +
				"JOIN reservations r ON rt.reservationId = r.reservationId " +
				"WHERE rt.table_id = ? " + // ✅ FIXED HERE
				"AND r.reservationDate = ? " +
				"AND r.startTime < ? " +
				"AND r.endTime > ?";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			for (String tableId : tableIds) {

				ps.setString(1, tableId);
				ps.setDate(2, Date.valueOf(date));
				ps.setTime(3, Time.valueOf(end));
				ps.setTime(4, Time.valueOf(start));

				ResultSet rs = ps.executeQuery();
				rs.next();

				if (rs.getInt(1) > 0) {
					return false; // ❌ at least one table busy
				}
			}
		}

		return true; // ✅ all tables free
	}

	public boolean isTableAvailable(
			LocalDate date,
			LocalTime start,
			LocalTime end,
			String tableId) throws SQLException {

		String sql = "SELECT COUNT(*) " +
				"FROM reservations r " +
				"JOIN reservation_table rt " +
				"ON r.reservationId = rt.reservationId " +
				"WHERE r.reservationDate = ? " +
				"AND rt.table_id = ? " +
				"AND r.startTime < ? " +
				"AND r.endTime > ? " +
				"AND r.status IN ('RESERVED', 'CONFIRMED')";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, Date.valueOf(date));
			ps.setString(2, tableId);
			ps.setTime(3, Time.valueOf(end));
			ps.setTime(4, Time.valueOf(start));

			ResultSet rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1) == 0;
		}
	}

	public void insertCustomerReservation(Reservation r) throws SQLException {

		Connection con = getConn();

		try {
			con.setAutoCommit(false); // 🔴 START TRANSACTION

			// =========================
			// 1️⃣ LOCK (double booking)
			// =========================
			String lockSql = "SELECT 1 FROM reservation_table rt " +
					"JOIN reservations r ON r.reservationId = rt.reservationId " +
					"WHERE rt.table_id = ? " +
					"AND r.reservationDate = ? " +
					"AND r.startTime < ? " +
					"AND r.endTime > ? " +
					"AND r.status NOT IN ('FINISHED','CANCELLED') " +
					"FOR UPDATE";

			try (PreparedStatement lockPs = con.prepareStatement(lockSql)) {
				for (String tableId : r.getTableIds()) {
					lockPs.setString(1, tableId);
					lockPs.setDate(2, Date.valueOf(r.getReservationDate()));
					lockPs.setTime(3, Time.valueOf(r.getStartTime()));
					lockPs.setTime(4, Time.valueOf(r.getEndTime()));

					try (ResultSet rs = lockPs.executeQuery()) {
						if (rs.next()) {
							throw new SQLException("選択した席は既に予約されています");
						}
					}
				}
			}

			// =========================
			// 2️⃣ INSERT reservations (Updated with couponId)
			// =========================
			String insertReservationSql = "INSERT INTO reservations " +
					"(customerId, reservationDate, startTime, endTime, adultCount, childCount, " +
					"reservationType, courseId, couponId, customerEmail, customer_name, status) " + // Added couponId
					"VALUES (?,?,?,?,?,?,?,?,?,?,?, 'RESERVED')"; // 11 placeholders before 'RESERVED'

			int reservationId;

			try (PreparedStatement ps = con.prepareStatement(insertReservationSql, Statement.RETURN_GENERATED_KEYS)) {

				if (r.getCustomerId() != null) {
					ps.setInt(1, r.getCustomerId());
				} else {
					ps.setNull(1, Types.INTEGER);
				}

				ps.setDate(2, Date.valueOf(r.getReservationDate()));
				ps.setTime(3, Time.valueOf(r.getStartTime()));
				ps.setTime(4, Time.valueOf(r.getEndTime()));
				ps.setInt(5, r.getAdultCount());
				ps.setInt(6, r.getChildCount());
				ps.setString(7, r.getReservationType());

				if (r.getCourseId() != null) {
					ps.setInt(8, r.getCourseId());
				} else {
					ps.setNull(8, Types.INTEGER);
				}

				// ✅ NEW: couponId logic
				if (r.getCouponId() != null && r.getCouponId() != 0) {
					ps.setInt(9, r.getCouponId());
				} else {
					ps.setNull(9, Types.INTEGER);
				}

				// Shifts to 10 and 11
				ps.setString(10, r.getCustomerEmail());
				ps.setString(11, r.getCustomerName());

				ps.executeUpdate();

				try (ResultSet keys = ps.getGeneratedKeys()) {
					if (keys.next()) {
						reservationId = keys.getInt(1);
					} else {
						throw new SQLException("Failed to retrieve reservation ID.");
					}
				}
			}

			// =========================
			// 3️⃣ INSERT reservation_table
			// =========================
			String insertTableSql = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?,?)";

			try (PreparedStatement ps = con.prepareStatement(insertTableSql)) {
				for (String tableId : r.getTableIds()) {
					ps.setInt(1, reservationId);
					ps.setString(2, tableId);
					ps.addBatch();
				}
				ps.executeBatch();
			}

			// =========================
			// 4️⃣ COMMIT
			// =========================
			con.commit();

		} catch (Exception e) {
			if (con != null)
				con.rollback(); // 🔴 FULL ROLLBACK
			throw e;
		} finally {
			if (con != null) {
				con.setAutoCommit(true);
				con.close();
			}
		}
	}

	public void insertWithTables(Reservation r, String[] tableIds) throws SQLException {

		String sqlRes = "INSERT INTO reservations (reservationDate,startTime,endTime," +
				"adultCount,childCount,customer_name,customerEmail,status) " +
				"VALUES (?,?,?,?,?,?,?,?)";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sqlRes, Statement.RETURN_GENERATED_KEYS)) {

			ps.setDate(1, Date.valueOf(r.getReservationDate()));
			ps.setTime(2, Time.valueOf(r.getStartTime()));
			ps.setTime(3, Time.valueOf(r.getEndTime()));
			ps.setInt(4, r.getAdultCount());
			ps.setInt(5, r.getChildCount());
			ps.setString(6, r.getCustomerName());
			ps.setString(7, r.getCustomerEmail());
			ps.setString(8, r.getStatus());

			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			int reservationId = rs.getInt(1);

			String sqlTable = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?, ?)";

			try (PreparedStatement ps2 = con.prepareStatement(sqlTable)) {
				for (String t : tableIds) {
					ps2.setInt(1, reservationId);
					ps2.setString(2, t);
					ps2.addBatch();
				}
				ps2.executeBatch();
			}
		}
	}

	public void insertWithTables(Reservation r) throws SQLException {

		String sqlReservation = "INSERT INTO reservations " +
				"(reservationDate,startTime,endTime,adultCount,childCount,customer_name,customerEmail,status) " +
				"VALUES (?,?,?,?,?,?,?,?)";

		String sqlTable = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?,?)";

		try (Connection con = getConn()) {
			con.setAutoCommit(false);

			// insert reservation
			try (PreparedStatement ps = con.prepareStatement(sqlReservation, Statement.RETURN_GENERATED_KEYS)) {

				ps.setDate(1, Date.valueOf(r.getReservationDate()));
				ps.setTime(2, Time.valueOf(r.getStartTime()));
				ps.setTime(3, Time.valueOf(r.getEndTime()));
				ps.setInt(4, r.getAdultCount());
				ps.setInt(5, r.getChildCount());
				ps.setString(6, r.getCustomerName());
				ps.setString(7, r.getCustomerEmail());
				ps.setString(8, r.getStatus());

				ps.executeUpdate();

				ResultSet rs = ps.getGeneratedKeys();
				rs.next();
				r.setReservationId(rs.getInt(1));
			}

			// insert tables
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
	
	public boolean requestCheckout(String table_id) {

        String sql = "UPDATE reservations r "
        		+ "JOIN reservation_table rt "
        		+ "ON r.reservationId = rt.reservationId "
        		+ "SET r.status = ? "
        		+ "WHERE rt.table_id = ? AND r.status = 'ARRIVED'";

        try (Connection con=getConn();
        		PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "BILL_REQUESTED");
            ps.setString(2, table_id);

            int result = ps.executeUpdate();
            return result == 1; // 1件更新されたら成功

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	public List<Reservation> findByDate(LocalDate date) {

		Map<Integer, Reservation> map = new LinkedHashMap<>();

		String sql = "SELECT r.*, rt.table_id " +
				"FROM reservations r " +
				"JOIN reservation_table rt ON r.reservationId = rt.reservationId " +
				"WHERE r.reservationDate = ?";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, Date.valueOf(date));
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("reservationId");

				Reservation r = map.get(id);
				if (r == null) {
					r = map(rs); // your existing mapper
					r.setTableIds(new ArrayList<>());
					map.put(id, r);
				}
				r.getTableIds().add(rs.getString("table_id"));
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

	public List<Reservation> findAll() {

		Map<Integer, Reservation> map = new LinkedHashMap<>();

		String sql = "SELECT r.*, rt.table_id " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt " +
				"ON r.reservationId = rt.reservationId " +
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
				if (tableId != null) {
					r.getTableIds().add(tableId);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ArrayList<>(map.values());
	}

	// =========================
	// FIND BY DATE (ADMIN DASH)
	// =========================
	public List<Reservation> findByDatelist(LocalDate date) {

		Map<Integer, Reservation> map = new LinkedHashMap<>();

		String sql = "SELECT r.*, rt.table_id " +
				"FROM reservations r " +
				"LEFT JOIN reservation_table rt " +
				"ON r.reservationId = rt.reservationId " +
				"WHERE r.reservationDate = ? " +
				"ORDER BY r.startTime, rt.table_id";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, Date.valueOf(date));
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("reservationId");

				Reservation r = map.get(id);
				if (r == null) {
					r = map(rs); // basic reservation info
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

	// =========================
	// COUNT BY MONTH
	// =========================
	public Map<LocalDate, Integer> countByMonth(YearMonth ym) {

		Map<LocalDate, Integer> map = new HashMap<>();

		String sql = "SELECT reservationDate, COUNT(*) cnt " +
				"FROM reservations " +
				"WHERE reservationDate BETWEEN ? AND ? " +
				"GROUP BY reservationDate";

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setDate(1, Date.valueOf(ym.atDay(1)));
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
	// UPDATE (ADMIN EDIT)
	// =========================
	public void update(Reservation r) {

		String sqlUpdate = "UPDATE reservations SET " +
				"reservationDate=?, startTime=?, endTime=?, " +
				"adultCount=?, childCount=?, customer_name=?, customerEmail=? " +
				"WHERE reservationId=?";

		String sqlDeleteTables = "DELETE FROM reservation_table WHERE reservationId=?";

		String sqlInsertTable = "INSERT INTO reservation_table (reservationId, table_id) VALUES (?, ?)";

		try (Connection con = getConn()) {

			con.setAutoCommit(false);

			// 1️⃣ update reservation
			try (PreparedStatement ps = con.prepareStatement(sqlUpdate)) {

				ps.setDate(1, Date.valueOf(r.getReservationDate()));
				ps.setTime(2, Time.valueOf(r.getStartTime()));
				ps.setTime(3, Time.valueOf(r.getEndTime()));
				ps.setInt(4, r.getAdultCount());
				ps.setInt(5, r.getChildCount());
				ps.setString(6, r.getCustomerName());
				ps.setString(7, r.getCustomerEmail());
				ps.setInt(8, r.getReservationId());

				ps.executeUpdate();
			}

			// 2️⃣ delete old tables
			try (PreparedStatement ps = con.prepareStatement(sqlDeleteTables)) {
				ps.setInt(1, r.getReservationId());
				ps.executeUpdate();
			}

			// 3️⃣ insert new tables (single OR multiple)
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

		try (Connection con = getConn();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, status);
			ps.setInt(2, id);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// =========================
	// DELETE (ADMIN)
	// =========================
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
	// =========================
	// MEMBER: RESERVATION HISTORY
	// =========================
	public List<Reservation> findByCustomerId(int customerId) {

	    Map<Integer, Reservation> map = new LinkedHashMap<>();

	    String sql =
	        "SELECT r.*, rt.table_id " +
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

	// =========================
	// MAPPER
	// =========================
	private Reservation map(ResultSet rs) throws SQLException {
		Reservation r = new Reservation();
		r.setReservationId(rs.getInt("reservationId"));
		r.setReservationDate(rs.getDate("reservationDate").toLocalDate());
		r.setStartTime(rs.getTime("startTime").toLocalTime());
		r.setEndTime(rs.getTime("endTime").toLocalTime());
		r.setCustomerName(rs.getString("customer_name"));
		r.setAdultCount(rs.getInt("adultCount"));
		r.setChildCount(rs.getInt("childCount"));
		r.setStatus(rs.getString("status"));
		r.setCustomerName(rs.getString("customer_name"));
		r.setCustomerEmail(rs.getString("customerEmail"));
		return r;
	}

}