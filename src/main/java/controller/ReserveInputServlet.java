package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import model.Reservation;
import service.Constants;

@WebServlet("/reserve/input")
public class ReserveInputServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		try {
			// Ensure correct encoding
			req.setCharacterEncoding("UTF-8");

			HttpSession session = req.getSession();

			// 1. Parse Basic Reservation Info
			LocalDate date = LocalDate.parse(req.getParameter("date"));
			LocalTime start = LocalTime.parse(req.getParameter("startTime"));
			LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);

			int adult = Integer.parseInt(req.getParameter("adult"));
			int child = Integer.parseInt(req.getParameter("child"));

			if (adult + child > 6) {
				throw new IllegalArgumentException("6名を超える場合はお電話ください");
			}

			// 2. Get or Create Reservation Object in Session
			Reservation r = (Reservation) session.getAttribute("pendingReservation");
			if (r == null) {
				r = new Reservation();
				r.setTableIds(new ArrayList<>());
			}

			// 3. Set Dates & Counts
			r.setReservationDate(date);
			r.setStartTime(start);
			r.setEndTime(end);
			r.setAdultCount(adult);
			r.setChildCount(child);

			// 4. Set Contact Info (Crucial Step)
			// We use the FORM parameters for everyone. This allows members 
			// to edit their details (e.g., use a different phone number for this booking).
			r.setCustomerName(req.getParameter("name"));
			r.setCustomerEmail(req.getParameter("email"));

			// ✅ CAPTURE PHONE FOR EVERYONE (GUEST & MEMBER)
			r.setCustomerPhone(req.getParameter("phone"));

			// 5. Link Member ID if logged in
			Customer loginCustomer = (Customer) session.getAttribute("customer");
			if (loginCustomer != null) {
				r.setCustomerId(loginCustomer.getUserId());
			} else {
				r.setCustomerId(null);
			}

			// 6. Save back to Session
			session.setAttribute("pendingReservation", r);

			// 7. Proceed to next step
			res.sendRedirect(req.getContextPath() + "/reserve/table");

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("error", e.getMessage());
			// Make sure this matches your actual JSP file name
			req.getRequestDispatcher("/reservation_form.jsp").forward(req, res);
		}
	}
}