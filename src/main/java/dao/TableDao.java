package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TableDao {

	private Connection con;

	public TableDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {
			con = DriverManager.getConnection(
					"jdbc:mysql://10.64.144.5:3306/24jy0234?characterEncoding=UTF-8",
					"24jy0234",
					"24jy0234");
			//			con = DriverManager.getConnection(
			//					"jdbc:mysql://127.0.0.1:3306/" + "myrestaurant?characterEncoding=UTF-8",
			//					"root", "shadowseeker");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public void connectionClose() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/** テーブルをロックする */
	public boolean lockTable(int tableId) throws SQLException {
		String sql = "UPDATE tables SET status='LOCKED' " +
				"WHERE tableId=? AND status='FREE'";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, tableId);

		return ps.executeUpdate() == 1;
	}

	/** テーブルを予約済みにする */
	public void reserveTable(int tableId) throws SQLException {
		String sql = "UPDATE tables SET status='RESERVED' WHERE tableId=?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, tableId);
		ps.executeUpdate();
	}

	public boolean requestCheckout(String table_id) {

		String sql = "UPDATE tables SET table_status = ? WHERE table_id = ?";

		try (PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, "会計依頼中");
			ps.setString(2, table_id);

			int result = ps.executeUpdate();
			return result == 1; // 1件更新されたら成功

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}