package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import model.Coupon;
import model.Customer;
import model.Reservation;

@WebServlet("/reserve/coupon")
public class ReserveCouponServlet extends HttpServlet {

	 @Override
	    protected void doGet(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {

	        HttpSession session = req.getSession();
	        Reservation r = (Reservation) session.getAttribute("pendingReservation");
	        Customer customer = (Customer) session.getAttribute("customer");

	        if (r == null || customer == null) {
	            res.sendRedirect(req.getContextPath() + "/reserve/form");
	            return;
	        }

	        try {
	            CouponDao dao = new CouponDao();

	            // ✅ FIX: use reservationType AS-IS
	            String type = r.getReservationType(); // SEAT_ONLY / COURSE

	            List<Coupon> coupons =
	            	    dao.findAvailableCoupons(
	            	        customer.getPoint(),
	            	        r.getReservationType(),
	            	        customer.getUserId()
	            	    );

	            req.setAttribute("couponList", coupons);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        req.getRequestDispatcher("/couponSelect.jsp").forward(req, res);
	        }

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
	        throws IOException {

	    HttpSession session = req.getSession();
	    Reservation r = (Reservation) session.getAttribute("pendingReservation");

	    if (r == null) {
	        res.sendRedirect(req.getContextPath() + "/reserve/form");
	        return;
	    }

	    String couponIdStr = req.getParameter("couponId");

	    if (couponIdStr != null && !couponIdStr.isEmpty()) {

	        int couponId = Integer.parseInt(couponIdStr);
	        r.setCouponId(couponId);

	        try {
	            CouponDao dao = new CouponDao();
	            Coupon selected = dao.findById(couponId);

	            session.setAttribute("selectedCoupon", selected);

	            // ★ KEY LINE: set required points automatically
	            r.setUsedPoint(selected.getMinPoint());

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	    } else {
	        // no coupon
	        r.setCouponId(null);
	        r.setUsedPoint(0);
	        session.removeAttribute("selectedCoupon");
	    }

	    session.setAttribute("pendingReservation", r);
	    res.sendRedirect(req.getContextPath() + "/reserve/confirm");
	}

}
