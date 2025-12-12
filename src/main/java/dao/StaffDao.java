package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Staff;

public class StaffDao {
	private Connection connection;
	public StaffDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection( "jdbc:mysql://127.0.0.1:3306/myrestaurant?useSSL=false&serverTimezone=UTC",
			        "root",
			        "shadowseeker");
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public Staff findStaffByEmailAndPassword(String email, String password) {
	    String sql = "SELECT * FROM Staff WHERE staffemail=? AND staffpassword=?";
	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setString(1, email.trim());
	        ps.setString(2, password.trim());
	        System.out.println("Executing SQL login: email=[" + email + "] password=[" + password + "]");
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            Staff staff = new Staff();
	            staff.setStaffId(rs.getInt("staffId"));
	            staff.setStaffName(rs.getString("staffname"));
	            staff.setStaffNameFurigana(rs.getString("staffnamefurigana"));
	            staff.setStaffType(rs.getString("stafftype"));
	            staff.setStaffPhone(rs.getString("staffphone"));
	            staff.setStaffEmail(rs.getString("staffemail"));
	            staff.setStaffAddress(rs.getString("staffaddress"));
	            staff.setStaffPassword(rs.getString("staffpassword"));
	            return staff;
	        } else {
	            System.out.println("No user found for given credentials.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public int insert(Staff staff) {
	    int result = 0;
	    String sql = "INSERT INTO staff (staffname, staffnamefurigana, stafftype, staffphone, staffemail, staffaddress, staffpassword) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?)";

	    try (PreparedStatement ps = connection.prepareStatement(sql)) {

	        ps.setString(1, staff.getStaffName());
	        ps.setString(2, staff.getStaffNameFurigana());
	        ps.setString(3, staff.getStaffType());
	        ps.setString(4, staff.getStaffPhone());
	        ps.setString(5, staff.getStaffEmail());
	        ps.setString(6, staff.getStaffAddress());
	        ps.setString(7, staff.getStaffPassword());

	        result = ps.executeUpdate();
	   

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return result;
	}
}
