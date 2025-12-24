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

		// 1️⃣ Read date parameter
		String dateParam = req.getParameter("date");
		LocalDate selectedDate;

		if (dateParam == null || dateParam.isEmpty()) {
			selectedDate = LocalDate.now();
		} else {
			selectedDate = LocalDate.parse(dateParam);
		}

		// 2️⃣ Fetch reservations by date
		List<Reservation> list = dao.findByDatelist(selectedDate);

		// 3️⃣ Set attributes
		req.setAttribute("date", selectedDate);
		req.setAttribute("list", list);

		// 4️⃣ Forward to JSP
		req.getRequestDispatcher(
				"/reservation/adminList.jsp").forward(req, res);
	}
}
