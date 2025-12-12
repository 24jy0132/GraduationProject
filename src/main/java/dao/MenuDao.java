package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Menu;
public class MenuDao {
	private Connection connection;
	public MenuDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection( "jdbc:mysql://127.0.0.1:3306/myrestaurant?useSSL=false&serverTimezone=UTC",
			        "root",
			        "shadowseeker");
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public List<Menu> getAllItem(){
		List<Menu>menu = new ArrayList<>();
		String sql = "select * from menu;";
		try {
			Statement smt = connection.createStatement();
			ResultSet rs = smt.executeQuery(sql);
			while(rs.next()) {
				Menu m = new Menu();
				m.setMenuId(rs.getInt("menuID"));
				m.setMenuname(rs.getString("menuname"));
				m.setDescription(rs.getString("description"));
				m.setPrice(rs.getDouble("price"));
				m.setCategory(rs.getString("category"));
				m.setImagePath(rs.getString("imagePath"));
				menu.add(m);
			}
			smt.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return menu;
	}
}
