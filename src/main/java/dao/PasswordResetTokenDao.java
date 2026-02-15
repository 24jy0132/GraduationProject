package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PasswordResetTokenDao {
	private Connection connection;

	public PasswordResetTokenDao() {
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

	public void saveResetToken(int userId, String token) {
		String sql = "INSERT INTO password_reset_tokens(user_id, token, expire_at) "
				+ "VALUES (?, ?, NOW() + INTERVAL 30 MINUTE)";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setString(2, token);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//token検証メソッド
	//	public Customer findByValidToken(String token) {
	//	    String sql =
	//	        "SELECT c.* " +
	//	        "FROM customers c " +
	//	        "JOIN password_reset_tokens t ON c.user_id = t.user_id " +
	//	        "WHERE t.token = ? AND t.expire_at > NOW()";
	//
	//	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	//	        ps.setString(1, token);
	//	        ResultSet rs = ps.executeQuery();
	//
	//	        if (rs.next()) {
	//	            Customer c = new Customer();
	//	            c.setUserId(rs.getInt("user_id"));
	//	            c.setEmail(rs.getString("email"));
	//	            c.setName(rs.getString("name"));
	//	            return c;
	//	        }
	//	    } catch (SQLException e) {
	//	        e.printStackTrace();
	//	    }
	//	    return null;
	//	}

	public Integer findValidUserIdByToken(String token) {
		String sql = "SELECT user_id FROM password_reset_tokens " +
				"WHERE token = ? AND expire_at > NOW()";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, token);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("user_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void deleteByToken(String token) {
		String sql = "DELETE FROM password_reset_tokens WHERE token = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, token);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
