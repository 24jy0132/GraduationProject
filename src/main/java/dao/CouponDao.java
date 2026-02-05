package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Coupon;

public class CouponDao {
	private Connection connection;

	public CouponDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {
						connection = DriverManager.getConnection(
								"jdbc:mysql://10.64.144.5:3306/24jy0234?characterEncoding=UTF-8",
								"24jy0234",
								"24jy0234");
//			connection = DriverManager.getConnection(
//					"jdbc:mysql://127.0.0.1:3306/" + "myrestaurant?characterEncoding=UTF-8",
//					"root", "shadowseeker");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public List<Coupon> findAll() throws SQLException {
		String sql = "SELECT * FROM coupon ORDER BY startDate DESC";
		List<Coupon> list = new ArrayList<>();

		try (
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Coupon c = map(rs);
				list.add(c);
			}
		}
		return list;
	}

	public void insert(Coupon c) throws SQLException {
		String sql = """
				    INSERT INTO coupon
				    (title,description,discountAmount,startDate,endDate,
				     minPoint,reservationType,imagePath)
				    VALUES (?,?,?,?,?,?,?,?)
				""";

		try (
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, c.getTitle());
			ps.setString(2, c.getDescription());
			ps.setInt(3, c.getDiscountAmount());
			ps.setDate(4, Date.valueOf(c.getStartDate()));
			ps.setDate(5, Date.valueOf(c.getEndDate()));
			ps.setInt(6, c.getMinPoint());
			ps.setString(7, c.getReservationType());
			ps.setString(8, c.getImagePath());

			ps.executeUpdate();
		}
	}

	public void delete(int couponId) throws SQLException {
		String sql = "DELETE FROM coupon WHERE couponId=?";
		try (
				PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, couponId);
			ps.executeUpdate();
		}
	}

	private Coupon map(ResultSet rs) throws SQLException {
		Coupon c = new Coupon();
		c.setCouponId(rs.getInt("couponId"));
		c.setTitle(rs.getString("title"));
		c.setDescription(rs.getString("description"));
		c.setDiscountAmount(rs.getInt("discountAmount"));
		c.setStartDate(rs.getDate("startDate").toLocalDate());
		c.setEndDate(rs.getDate("endDate").toLocalDate());
		c.setMinPoint(rs.getInt("minPoint"));
		c.setReservationType(rs.getString("reservationType"));
		c.setImagePath(rs.getString("imagePath"));
		return c;
	}

	public List<Coupon> findAvailableCoupons(
			int customerPoint,
			String reservationType,
			int userId) throws SQLException {

		List<Coupon> list = new ArrayList<>();

		String sql = """
				    SELECT c.*
				    FROM coupon c
				    WHERE c.minPoint <= ?
				      AND c.startDate <= ?
				      AND c.endDate >= ?
				      AND (c.reservationType = 'ANY' OR c.reservationType = ?)
				      AND NOT EXISTS (
				          SELECT 1
				          FROM coupon_usage cu
				          WHERE cu.userId = ?
				            AND cu.couponId = c.couponId
				      )
				""";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {

			LocalDate today = LocalDate.now();

			ps.setInt(1, customerPoint);
			ps.setDate(2, Date.valueOf(today));
			ps.setDate(3, Date.valueOf(today));
			ps.setString(4, reservationType);
			ps.setInt(5, userId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(map(rs));
			}
		}
		return list;
	}

	public Coupon findById(int couponId) throws Exception {

		String sql = "SELECT * FROM coupon WHERE couponId = ?";

		try (
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, couponId);

			try (ResultSet rs = ps.executeQuery()) {

				if (rs.next()) {
					Coupon c = new Coupon();

					c.setCouponId(rs.getInt("couponId"));
					c.setTitle(rs.getString("title"));
					c.setDescription(rs.getString("description"));
					c.setDiscountAmount(rs.getInt("discountAmount"));
					c.setStartDate(rs.getDate("startDate").toLocalDate());
					c.setEndDate(rs.getDate("endDate").toLocalDate());
					c.setMinPoint(rs.getInt("minPoint"));
					c.setReservationType(rs.getString("reservationType"));
					c.setImagePath(rs.getString("imagePath"));

					return c;
				}
			}
		}

		return null; // not found
	}

	public void update(Coupon c) throws SQLException {

		String sql = """
				    UPDATE coupon
				    SET title=?, description=?, discountAmount=?,
				        startDate=?, endDate=?, minPoint=?,
				        reservationType=?, imagePath=?
				    WHERE couponId=?
				""";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, c.getTitle());
			ps.setString(2, c.getDescription());
			ps.setInt(3, c.getDiscountAmount());
			ps.setDate(4, Date.valueOf(c.getStartDate()));
			ps.setDate(5, Date.valueOf(c.getEndDate()));
			ps.setInt(6, c.getMinPoint());
			ps.setString(7, c.getReservationType());
			ps.setString(8, c.getImagePath());
			ps.setInt(9, c.getCouponId());

			ps.executeUpdate();
		}
	}

}
