package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

@WebServlet("/adminreservation/list")
public class AdminReservationListServlet extends HttpServlet {

	private ReservationDao dao = new ReservationDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		String allParam = req.getParameter("all");
		String dateParam = req.getParameter("date");

		List<Reservation> list;
		LocalDate selectedDate = null;

		// 🔄 SHOW ALL RESERVATIONS
		if ("true".equals(allParam)) {

			list = dao.findAll(); // ✅ ALL reservations
			selectedDate = null; // no date filter

		} else {
			// 📅 DATE FILTER (default = today)
			if (dateParam == null || dateParam.isEmpty()) {
				selectedDate = LocalDate.now();
			} else {
				selectedDate = LocalDate.parse(dateParam);
			}

			list = dao.findByDatelist(selectedDate);
		}

		// Set attributes
		req.setAttribute("date", selectedDate);
		req.setAttribute("list", list);

		// Forward
		req.getRequestDispatcher("/reservation/adminList.jsp")
				.forward(req, res);
	}

}
