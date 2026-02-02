package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;

@WebServlet("/reserve/table")
public class ReserveTableServlet extends HttpServlet {

    // Helper to get ideal tables
    private String[] candidateTables(int total) {
        if (total <= 2)
            return new String[] { "A1", "A2" };
        if (total <= 4)
            return new String[] { "T1", "T2", "T3", "T4" };
        return new String[] { "Z1", "Z2", "Z3", "Z4" };
    }

    // Helper to get ALL tables (for checking overall availability)
    private String[] allTables() {
        return new String[] { "A1", "A2", "T1", "T2", "T3", "T4", "Z1", "Z2", "Z3", "Z4" };
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Reservation r = (Reservation) req.getSession().getAttribute("pendingReservation");

        if (r == null) {
            res.sendRedirect(req.getContextPath() + "/reserve");
            return;
        }

        ReservationDao dao = new ReservationDao();
        Set<String> available = new HashSet<>();

        int total = r.getAdultCount() + r.getChildCount();
        
        // 1. Get primary candidates (e.g., A1, A2 for 2 people)
        String[] candidate = candidateTables(total);

        // 2. Check availability for PRIMARY candidates
        for (String t : candidate) {
            try {
                if (dao.isTableAvailable(r.getReservationDate(), r.getStartTime(), r.getEndTime(), t)) {
                    available.add(t);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 3. LOGIC CHECK: If no primary tables are available
        if (available.isEmpty()) {
            boolean largerTableAvailable = false;
            
            // Check ALL tables to see if the restaurant has ANY space left
            String[] all = allTables();
            for (String t : all) {
                try {
                    // We only care if a table is free, we don't need to store it
                    if (dao.isTableAvailable(r.getReservationDate(), r.getStartTime(), r.getEndTime(), t)) {
                        largerTableAvailable = true;
                        break; // Found one, stop checking
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (largerTableAvailable) {
                // CASE: 2-seaters are full, but 4-seaters exist.
                // User cannot book online, but should call.
                req.setAttribute("globalError", "ご希望の人数の席はWEB予約分が満席です。<br>広いお席などが空いている可能性がありますので、店舗へ直接お電話ください。<br>TEL: 03-XXXX-XXXX");
            } else {
                // CASE: The entire restaurant is full.
                req.setAttribute("globalError", "申し訳ありません。ご指定の日時は全席満席です。");
            }
        }

        req.setAttribute("candidateTables", candidate);
        req.setAttribute("availableTables", available);
        req.getRequestDispatcher("/tableLayout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Reservation r = (Reservation) session.getAttribute("pendingReservation");

        if (r == null) {
            res.sendRedirect(req.getContextPath() + "/reserve/form");
            return;
        }

        String tableId = req.getParameter("tableId");
        
        // Validation: If user forces a post when tableId is empty
        if (tableId == null || tableId.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/reserve/table");
            return;
        }

        if (r.getTableIds() == null) {
            r.setTableIds(new ArrayList<>());
        }

        r.getTableIds().clear();
        r.getTableIds().add(tableId);

        session.setAttribute("pendingReservation", r);

        res.sendRedirect(req.getContextPath() + "/reserve/course");
    }
}