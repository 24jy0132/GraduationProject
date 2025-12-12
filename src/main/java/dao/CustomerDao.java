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
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection( "jdbc:mysql://127.0.0.1:3306/myrestaurant?useSSL=false&serverTimezone=UTC",
			        "root",
			        "shadowseeker");
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	public Customer findByEmailAndPassword(String email, String password) {
	    String sql = "SELECT * FROM customers WHERE email=? AND password=?";
	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setString(1, email.trim());
	        ps.setString(2, password.trim());
	        System.out.println("Executing SQL login: email=[" + email + "] password=[" + password + "]");
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
	public int insert(Customer customer) {
	    int result = 0;
	    String sql = "INSERT INTO customers (name, nameKana, email, phone, password) VALUES (?, ?, ?, ?, ?)";

	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setString(1, customer.getName());
	        ps.setString(2, customer.getNameKana());
	        ps.setString(3, customer.getEmail());
	        ps.setString(4, customer.getPhone());
	        ps.setString(5, customer.getPassword());

	        result = ps.executeUpdate();
	        System.out.println("Inserted user: " + customer.getEmail() + " result=" + result);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return result;
	}
}
