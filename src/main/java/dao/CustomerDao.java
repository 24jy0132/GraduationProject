package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer;

public class CustomerDao {
	private Connection connection;

	public CustomerDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {

			//			connection = DriverManager.getConnection(
			//			"jdbc:mysql://10.64.144.5:3306/24jy0234?characterEncoding=UTF-8",
			//			"24jy0234",
			//			"24jy0234");
			connection = DriverManager.getConnection(
					"jdbc:mysql://127.0.0.1:3306/" + "myrestaurant?characterEncoding=UTF-8",
					"root", "shadowseeker");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public Customer findByEmailAndPassword(String email, String password) {
		String sql = "SELECT * FROM customers WHERE email=? AND password=?";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, email.trim());
			ps.setString(2, password.trim());

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return map(rs); // ✅ FIX
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Customer findByEmail(String email) {
		String sql = "SELECT * FROM customers WHERE email=?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, email.trim());
			System.out.println("Executing SQL login: email=[" + email + "] ");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Customer c = new Customer();
				c.setUserId(rs.getInt("userId"));
				c.setName(rs.getString("name"));
				c.setEmail(rs.getString("email"));
				c.setPassword(rs.getString("password"));
				System.out.println("User found: " + c.getEmail());
				return c;
			} else {
				System.out.println("No user found for given credentials.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Customer findByEmailAndPhone(String email, String phone) {
		String sql = "SELECT * FROM customers WHERE email = ? AND phone = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, email.trim());
			ps.setString(2, phone.trim());

			System.out.println("Executing SQL: email=[" + email + "] phone=[" + phone + "]");

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Customer c = new Customer();
				c.setUserId(rs.getInt("userId"));
				c.setName(rs.getString("name"));
				c.setEmail(rs.getString("email"));
				c.setPhone(rs.getString("phone"));
				return c;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Customer findById1(int userId) {
		String sql = "SELECT * FROM customers WHERE userId = ?";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Customer c = new Customer();
				c.setUserId(rs.getInt("userId"));
				c.setName(rs.getString("name"));
				c.setEmail(rs.getString("email"));
				c.setPhone(rs.getString("phone"));
				// パスワードは原則セットしない（必要な場合のみ）
				return c;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int insert(Customer customer) {
		int result = 0;
		String sql = "INSERT INTO customers (name, nameKana, email, phone, password,point) VALUES (?, ?, ?, ?, ?,?)";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, customer.getName());
			ps.setString(2, customer.getNameKana());
			ps.setString(3, customer.getEmail());
			ps.setString(4, customer.getPhone());
			ps.setString(5, customer.getPassword());
			ps.setInt(6, customer.getPoint());

			result = ps.executeUpdate();
			System.out.println("Inserted user: " + customer.getEmail() + " result=" + result);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public void updatePassword(int userId, String hashedPassword) {
		String sql = "UPDATE customers SET password = ? WHERE userId = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, hashedPassword);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Customer findById(int userId) {

		String sql = "SELECT * FROM customers WHERE userId=?";

		try (
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return map(rs);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean update(Customer customer) {

		String sql = "UPDATE customers SET name=?, nameKana=?, email=?, phone=? WHERE userId=?";

		try (
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, customer.getName());
			ps.setString(2, customer.getNameKana());
			ps.setString(3, customer.getEmail());
			ps.setString(4, customer.getPhone());
			ps.setInt(5, customer.getUserId());

			return ps.executeUpdate() == 1;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public void deleteCustomerWithAnswers(int userId) {

		String deleteSurveySql = "DELETE FROM survey_answer WHERE userId=?";
		String deleteCustomerSql = "DELETE FROM customers WHERE userId=?";

		try {
			connection.setAutoCommit(false); // 🔒 transaction

			try (PreparedStatement ps1 = connection.prepareStatement(deleteSurveySql)) {
				ps1.setInt(1, userId);
				ps1.executeUpdate();
			}

			try (PreparedStatement ps2 = connection.prepareStatement(deleteCustomerSql)) {
				ps2.setInt(1, userId);
				ps2.executeUpdate();
			}

			connection.commit(); // ✅ success

		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException ex) {
			}
			e.printStackTrace();
		}
	}

	private Customer map(ResultSet rs) throws SQLException {

		Customer c = new Customer();
		c.setUserId(rs.getInt("userId"));
		c.setName(rs.getString("name"));
		c.setNameKana(rs.getString("nameKana"));
		c.setEmail(rs.getString("email"));
		c.setPhone(rs.getString("phone"));
		c.setPassword(rs.getString("password"));
		c.setPoint(rs.getInt("point"));
		return c;
	}

	public int getPointByUserId(int userId) {
		String sql = "SELECT point FROM customers WHERE userId = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("point");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

}
