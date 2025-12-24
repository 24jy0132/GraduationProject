package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TableDao {
	private Connection connection;

	public TableDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {
			connection = DriverManager.getConnection("jdbc:mysql://10.64.144.5:3306/" + "24jy0234?characterEncoding=UTF-8",
					"24jy0234", "24jy0234");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	/**
     * 会計依頼状態に更新する
     */
    public boolean requestCheckout(String table_id) {

        String sql = "UPDATE tables SET table_status = ? WHERE table_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

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

