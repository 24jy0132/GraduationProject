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
                "24jy0234"
            );
        } catch (SQLException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    public void connectionClose() {
        try {
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /** テーブルをロックする */
    public boolean lockTable(int tableId) throws SQLException {
        String sql =
            "UPDATE tables SET status='LOCKED' " +
            "WHERE tableId=? AND status='FREE'";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, tableId);

        return ps.executeUpdate() == 1;
    }

    /** テーブルを予約済みにする */
    public void reserveTable(int tableId) throws SQLException {
        String sql =
            "UPDATE tables SET status='RESERVED' WHERE tableId=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, tableId);
        ps.executeUpdate();
    }
}