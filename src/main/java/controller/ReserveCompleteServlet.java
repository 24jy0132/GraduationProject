package controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDao;
import dao.ReservationDao;
import model.Customer;
import model.Reservation;
import service.ReserveRegistration_MailSender;

@WebServlet("/reserve/complete")
public class ReserveCompleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		Reservation r = (Reservation) session.getAttribute("pendingReservation");

		if (r == null) {
			res.sendRedirect(req.getContextPath() + "/reserve");
			return;
		}

		try {
			new ReservationDao().insertCustomerReservation(r);

			// =========================
			// REFRESH CUSTOMER SESSION (IMPORTANT)
			// =========================
			Customer loginCustomer = (Customer) session.getAttribute("customer");

			if (loginCustomer != null) {
				CustomerDao customerDao = new CustomerDao();
				Customer refreshed = customerDao.findById(loginCustomer.getUserId());

				session.setAttribute("customer", refreshed);
			}

			// mail sending (unchanged)
			try {
				ReserveRegistration_MailSender.send(r.getCustomerEmail(), r);
			} catch (Exception mailEx) {
				mailEx.printStackTrace();
			}

			session.removeAttribute("pendingReservation");
			session.removeAttribute("selectedCoupon");

			res.sendRedirect(req.getContextPath() + "/complete.jsp");
		} catch (Exception e) {

			// =========================
			// POINT INSUFFICIENT
			// =========================
			 // =========================
		    // POINT INSUFFICIENT
		    // =========================
		    if (e instanceof SQLException &&
		        e.getMessage() != null &&
		        e.getMessage().contains("ポイント")) {

		        session.removeAttribute("selectedCoupon");

		        req.setAttribute(
		            "errorMessage",
		            "ポイントが不足しています。クーポンを変更してください。"
		        );

		        req.getRequestDispatcher("/point_error.jsp")
		           .forward(req, res);
		        return;
		    }

		    // =========================
		    // PAST DATE / TIME ERROR
		    // =========================
		    if (e instanceof SQLException &&
		        e.getMessage() != null &&
		        e.getMessage().contains("過去")) {

		        // clean session so user must retry
		        session.removeAttribute("pendingReservation");
		        session.removeAttribute("selectedCoupon");

		        req.setAttribute(
		            "errorMessage",
		            e.getMessage()
		        );

		        req.getRequestDispatcher("/reservation/error.jsp")
		           .forward(req, res);
		        return;
		    }

		    // =========================
		    // OTHER UNKNOWN ERROR
		    // =========================
		    e.printStackTrace();

		    req.setAttribute("errorMessage", "予約登録に失敗しました。もう一度お試しください。");
		    req.getRequestDispatcher("/reserve/error.jsp")
		       .forward(req, res);
		
		}
	}
}
