package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Reservation;

@WebServlet("/reserve/form")
public class ReserveFormServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		Reservation r = (Reservation) session.getAttribute("pendingReservation");

		// 🔴 BLOCK if already in reservation flow
		if (r != null && r.getTableIds() != null) {
			res.sendRedirect(req.getContextPath() + "/reserve/table");
			return;
		}

		req.getRequestDispatcher("/reserveForm.jsp").forward(req, res);
	}
}
