package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Menu;

//DriverManager.getConnection("jdbc:mysql://10.64.144.5:3306/"+ "24jy0234?characterEncoding=UTF-8","24jy0234","24jy0234");
public class MenuDao {
	private Connection con = null;

	public MenuDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://10.64.144.5:3306/" + "24jy0234?characterEncoding=UTF-8",
					"24jy0234", "24jy0234");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public void connectionClose() {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Menu> findAll() {
		List<Menu> ar = new ArrayList<>();
		String sql = "select* from menu";
		try {
			PreparedStatement state = con.prepareStatement(sql);
			ResultSet rs = state.executeQuery();

			while (rs.next()) {
				Menu menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));

				ar.add(menu);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		return ar;
	}

	public List<Menu> findSurveyMenu() {
		List<Menu> ar = new ArrayList<>();
		String sql = "select* from menu where isSurveyTarget =1";
		try {
			PreparedStatement state = con.prepareStatement(sql);
			ResultSet rs = state.executeQuery();

			while (rs.next()) {
				Menu menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));

				ar.add(menu);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		return ar;
	}

	public List<Menu> findNewMenu() {
		List<Menu> ar = new ArrayList<>();
		String sql = "select* from menu where isNew = ?";

		try {
			PreparedStatement state = con.prepareStatement(sql);
			state.setInt(1, 1);
			ResultSet rs = state.executeQuery();

			while (rs.next()) {
				Menu menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));

				ar.add(menu);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		return ar;
	}

	public Menu findById(int menuId) {
		Menu menu = null;
		String sql = "SELECT * FROM menu WHERE menuId = ?";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, menuId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					menu = new Menu();
					menu.setMenuId(rs.getInt("menuId"));
					menu.setMenuName(rs.getString("menuName"));
					menu.setDescription(rs.getString("description"));
					menu.setPrice(rs.getInt("price"));
					menu.setCategory(rs.getString("category"));
					menu.setImagePath(rs.getString("imagePath"));
					menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
					menu.setSurveyId(rs.getInt("surveyId"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return menu;
	}

	public List<Menu> findMainMenu() {
		List<Menu> ar = new ArrayList<Menu>();
		Menu menu = null;
		String sql = "Select* from menu where category= ?";
		try (PreparedStatement state = con.prepareStatement(sql)) {
			state.setString(1, "main");

			try (ResultSet rs = state.executeQuery()) {
				while (rs.next()) {
					menu = new Menu();
					menu.setMenuId(rs.getInt("menuId"));
					menu.setMenuName(rs.getString("menuName"));
					menu.setDescription(rs.getString("description"));
					menu.setPrice(rs.getInt("price"));
					menu.setCategory(rs.getString("category"));
					menu.setImagePath(rs.getString("imagePath"));
					menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
					menu.setSurveyId(rs.getInt("surveyId"));
					ar.add(menu);

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ar;
	}
	public List<Menu> findAlaCarteMenu(){
		List<Menu> ar = new ArrayList<Menu>();
		Menu menu = null;
		String sql = "Select* from menu where category = ?";
		try(PreparedStatement state = con.prepareStatement(sql)){
			state.setString(1, "アラカルト");
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));
				ar.add(menu);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return ar;
	}
	public List<Menu> findSaladSoup(){
		List<Menu> ar = new ArrayList<Menu>();
		Menu menu = null;
		String sql = "Select* from menu where category = ?";
		try(PreparedStatement state = con.prepareStatement(sql)){
			state.setString(1, "サラダ．スープ．その他");
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));
				ar.add(menu);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return ar;
	}
	public List<Menu> findDrinks(){
		List<Menu> ar = new ArrayList<Menu>();
		Menu menu = null;
		String sql = "Select* from menu where category = ?";
		try(PreparedStatement state = con.prepareStatement(sql)){
			state.setString(1, "ドリンク");
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				menu = new Menu();
				menu.setMenuId(rs.getInt("menuId"));
				menu.setMenuName(rs.getString("menuName"));
				menu.setDescription(rs.getString("description"));
				menu.setPrice(rs.getInt("price"));
				menu.setCategory(rs.getString("category"));
				menu.setImagePath(rs.getString("imagePath"));
				menu.setSurveyTarget(rs.getBoolean("isSurveyTarget"));
				menu.setSurveyId(rs.getInt("surveyId"));
				ar.add(menu);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return ar;
	}
}
