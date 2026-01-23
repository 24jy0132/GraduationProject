package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Customer;
import model.Reservation;

@WebServlet("/member/reservations")
public class MemberReservationListServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		// 🔒 login check
		if (session == null || session.getAttribute("customer") == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp"); // Ensure path is correct
			return;
		}

		Customer customer = (Customer) session.getAttribute("customer");

		ReservationDao dao = new ReservationDao();

		// ✅ FIX: Pass the Customer ID, not the points!
		List<Reservation> list = dao.findByCustomerId(customer.getUserId());

		req.setAttribute("reservations", list);
		req.getRequestDispatcher("/memberReservationHistory.jsp")
				.forward(req, resp);
	}
}
