package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Reservation;
import service.Constants;

public class ReservationDao {

    private Connection con;

    public ReservationDao() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://10.64.144.5:3306/24jy0234"
                + "?characterEncoding=UTF-8&serverTimezone=Asia/Tokyo",
                "24jy0234",
                "24jy0234"
            );
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    public void close() {
        try { if (con != null) con.close(); }
        catch (SQLException e) { e.printStackTrace(); }
    }

    // 🔴 AUTO ASSIGN TABLE (A/T/Z + 2-hour overlap check)
    public String assignTable(LocalDate date, LocalTime start, int totalPeople)
            throws SQLException {

        LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);

        String[] tables;
        if (totalPeople <= 2)
            tables = new String[]{"A1","A2"};
        else if (totalPeople <= 4)
            tables = new String[]{"T1","T2","T3","T4"};
        else
            tables = new String[]{"Z1","Z2","Z3","Z4"};

        for (String table : tables) {
            String sql =
              "SELECT COUNT(*) FROM reservations " +
              "WHERE reservationDate=? AND tableId=? " +
              "AND startTime < ? AND endTime > ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(date));
            ps.setString(2, table);
            ps.setTime(3, Time.valueOf(end));
            ps.setTime(4, Time.valueOf(start));

            ResultSet rs = ps.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {
                return table; // available
            }
        }
        return null; // all tables full
    }

    // INSERT
    public void insert(Reservation r) throws SQLException {

        r.setEndTime(
            r.getStartTime().plusMinutes(Constants.DURATION_MINUTES)
        );

        String sql =
          "INSERT INTO reservations " +
          "(reservationDate,startTime,endTime,adultCount,childCount,tableId,customer_name,customerEmail) " +
          "VALUES (?,?,?,?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setDate(1, Date.valueOf(r.getReservationDate()));
        ps.setTime(2, Time.valueOf(r.getStartTime()));
        ps.setTime(3, Time.valueOf(r.getEndTime()));
        ps.setInt(4, r.getAdultCount());
        ps.setInt(5, r.getChildCount());
        ps.setString(6, r.getTableId());
        ps.setString(7, r.getCustomerName());
        ps.setString(8, r.getCustomerEmail());

        ps.executeUpdate();
    }

    public Map<LocalDate,Integer> countByMonth(YearMonth ym) {
        Map<LocalDate,Integer> map = new HashMap<>();

        String sql =
          "SELECT reservationDate, COUNT(*) cnt " +
          "FROM reservations " +
          "WHERE reservationDate BETWEEN ? AND ? " +
          "GROUP BY reservationDate";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(ym.atDay(1)));
            ps.setDate(2, java.sql.Date.valueOf(ym.atEndOfMonth()));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(
                    rs.getDate("reservationDate").toLocalDate(),
                    rs.getInt("cnt")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
    
    public List<Reservation> findByDate(LocalDate date) {
        List<Reservation> list = new ArrayList<>();

        String sql =
          "SELECT * FROM reservations " +
          "WHERE reservationDate = ? " +
          "ORDER BY tableId, startTime";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(date));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("reservationId"));
                r.setReservationDate(rs.getDate("reservationDate").toLocalDate());
                r.setStartTime(rs.getTime("startTime").toLocalTime());
                r.setEndTime(rs.getTime("endTime").toLocalTime());
                r.setTableId(rs.getString("tableId"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setAdultCount(rs.getInt("adultCount"));
                r.setChildCount(rs.getInt("childCount"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Reservation> findAll() {

        List<Reservation> list = new ArrayList<>();

        String sql = """
            SELECT *
            FROM reservations
            ORDER BY reservationDate, startTime
        """;

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reservation r = new Reservation();

                r.setReservationId(rs.getInt("reservationId"));
                r.setReservationDate(rs.getDate("reservationDate").toLocalDate());
                r.setStartTime(rs.getTime("startTime").toLocalTime());
                r.setEndTime(rs.getTime("endTime").toLocalTime());
                r.setTableId(rs.getString("tableId"));
                r.setCustomerName(rs.getString("customer_name"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Reservation> findByDatelist(LocalDate date) {
        List<Reservation> list = new ArrayList<>();

        String sql = """
            SELECT *
            FROM reservations
            WHERE reservationDate = ?
            ORDER BY startTime
        """;

        try (
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(date));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("reservationId"));
                r.setReservationDate(rs.getDate("reservationDate").toLocalDate());
                r.setStartTime(rs.getTime("startTime").toLocalTime());
                r.setEndTime(rs.getTime("endTime").toLocalTime());
                r.setTableId(rs.getString("tableId"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setAdultCount(rs.getInt("adultCount"));
                r.setChildCount(rs.getInt("childCount"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}