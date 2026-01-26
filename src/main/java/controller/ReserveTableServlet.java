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

	private String[] candidateTables(int total) {
		if (total <= 2)
			return new String[] { "A1", "A2" };
		if (total <= 4)
			return new String[] { "T1", "T2", "T3", "T4" };
		return new String[] { "Z1", "Z2", "Z3", "Z4" };
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
		String[] candidate = candidateTables(total);

		for (String t : candidate) {
			try {
				if (dao.isTableAvailable(
						r.getReservationDate(),
						r.getStartTime(),
						r.getEndTime(),
						t)) {
					available.add(t);
				}
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
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
	    if (tableId == null) {
	        res.sendRedirect(req.getContextPath() + "/reserve/table");
	        return;
	    }

	  
	    if (r.getTableIds() == null) {
	        r.setTableIds(new ArrayList<>());
	    }

	    r.getTableIds().clear();
	    r.getTableIds().add(tableId);

	    
	    req.getSession().setAttribute("pendingReservation", r);

	    res.sendRedirect(req.getContextPath() + "/reserve/course");
	}

}
