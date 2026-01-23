package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.MenuDao;
import model.Customer;
import model.Menu;
import model.Reservation;

@WebServlet("/reserve/course")
public class ReserveCourseServlet extends HttpServlet {

	// ======================
	// GET → show course page
	// ======================
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		Reservation r = (Reservation) session.getAttribute("pendingReservation");

		if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
			res.sendRedirect(req.getContextPath() + "/reserve/form");
			return;
		}

		// 🔴 Load courses from DB
		MenuDao dao = new MenuDao();
		List<Menu> courses;
		try {
			courses = dao.findCourses();
			// 🔴 Set to request
			req.setAttribute("courses", courses);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		// 🔴 Forward to JSP
		req.getRequestDispatcher("/courseSelect.jsp").forward(req, res);
	}

	// ======================
	// POST → save selection
	// ======================
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		HttpSession session = req.getSession();
		Reservation r = (Reservation) session.getAttribute("pendingReservation");

		if (r == null) {
			res.sendRedirect(req.getContextPath() + "/reserve/form");
			return;
		}

		String type = req.getParameter("reservationType");
		r.setReservationType(type);

		if ("COURSE".equals(type)) {
			r.setCourseId(Integer.parseInt(req.getParameter("courseId")));
		} else {
			r.setCourseId(null);
		}

		session.setAttribute("pendingReservation", r);
		Customer loginCustomer = (Customer) session.getAttribute("customer");

		if (loginCustomer != null) {
			// MEMBER → coupon step
			res.sendRedirect(req.getContextPath() + "/reserve/coupon");
		} else {
			// GUEST → skip coupon
			res.sendRedirect(req.getContextPath() + "/reserve/confirm");
		}

	}
}
