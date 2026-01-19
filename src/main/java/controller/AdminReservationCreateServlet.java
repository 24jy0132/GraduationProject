package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;
import service.Constants;

@WebServlet("/admin/reserve")
public class AdminReservationCreateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		LocalDate date = LocalDate.parse(req.getParameter("date"));
		LocalTime start = LocalTime.parse(req.getParameter("startTime"));
		LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);

		String[] tableIds = req.getParameterValues("tableIds");
		if (tableIds == null || tableIds.length == 0) {
			res.sendRedirect(req.getContextPath() + "/reservation/adminReserveForm.jsp");
			return;
		}

		Reservation r = new Reservation();
		r.setReservationDate(date);
		r.setStartTime(start);
		r.setEndTime(end);
		r.setAdultCount(Integer.parseInt(req.getParameter("adult")));
		r.setChildCount(Integer.parseInt(req.getParameter("child")));
		r.setCustomerName(req.getParameter("name"));
		r.setCustomerEmail(req.getParameter("email"));
		r.setStatus("RESERVED");

		ReservationDao dao = new ReservationDao();

		try {
			if (!dao.areTablesAvailable(date, start, end, tableIds)) {
				res.sendRedirect(req.getContextPath()
					+ "/reservation/adminReserveForm.jsp?error=table_taken");
				return;
			}

			dao.insertWithTables(r, tableIds);

			res.sendRedirect(req.getContextPath() + "/admin");

		} catch (Exception e) {
			e.printStackTrace();
			res.sendRedirect(req.getContextPath()
				+ "/reservation/adminReserveForm.jsp?error=system");
		}
	}
}


