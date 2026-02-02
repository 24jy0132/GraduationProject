package controller;

import java.io.IOException;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CouponDao;
import model.Coupon;

/**
 * Servlet implementation class CouponInsertServlet
 */
@WebServlet("/admin/coupon/insert")
public class CouponInsertServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			Coupon c = new Coupon();
			c.setTitle(req.getParameter("title"));
			c.setDescription(req.getParameter("description"));
			c.setDiscountAmount(Integer.parseInt(req.getParameter("discountAmount")));
			c.setStartDate(LocalDate.parse(req.getParameter("startDate")));
			c.setEndDate(LocalDate.parse(req.getParameter("endDate")));
			c.setMinPoint(Integer.parseInt(req.getParameter("minPoint")));
			c.setReservationType(req.getParameter("reservationType"));
			c.setImagePath(req.getParameter("imagePath"));

			new CouponDao().insert(c);

			resp.sendRedirect(req.getContextPath() + "/admin/coupon/list");

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
