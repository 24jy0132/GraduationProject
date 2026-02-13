package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

/**
 * Servlet implementation class AdminReservationForceServlet
 */
@WebServlet("/admin/reserve/force")
public class AdminReservationForceServlet extends HttpServlet {

	private final ReservationDao dao = new ReservationDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {

		Reservation r = (Reservation) req.getSession()
				.getAttribute("pendingReservation");

		if (r == null) {
			res.sendRedirect(req.getContextPath() + "/admin");
			return;
		}

		try {
			// ✅ CANCEL old reservations first
			dao.cancelConflictingReservations(
					r.getReservationDate(),
					r.getStartTime(),
					r.getEndTime(),
					r.getTableIds());

			// ✅ Insert new one
			dao.insertCustomerReservation(r);

			req.getSession().removeAttribute("pendingReservation");

			res.sendRedirect(req.getContextPath()
					+ "/adminreservation/list?date=" + r.getReservationDate());

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("errorMessage", "強制予約に失敗しました");
			req.getRequestDispatcher("/Admin/error.jsp")
					.forward(req, res);
		}
	}
}
