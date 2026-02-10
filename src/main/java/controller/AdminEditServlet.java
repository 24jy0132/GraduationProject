package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.MenuDao;
import dao.ReservationDao;
import model.Menu;
import model.Reservation;

@WebServlet("/admin/edit")
public class AdminEditServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		try {
			String idParam = req.getParameter("id");

			if (idParam == null || idParam.isBlank()) {
				res.sendRedirect(req.getContextPath() + "/admin");
				return;
			}

			int id = Integer.parseInt(idParam);

			ReservationDao rdao = new ReservationDao();
			Reservation r = rdao.findById(id);

			if (r == null) {
				res.sendRedirect(req.getContextPath() + "/admin");
				return;
			}

			MenuDao mdao = new MenuDao();
			List<Menu> courseList = mdao.findCourses(); // ✅ ONLY courses

			req.setAttribute("res", r);
			req.setAttribute("courseList", courseList);

			req.getRequestDispatcher("/Admin/edit.jsp").forward(req, res);

		} catch (Exception e) {
			e.printStackTrace();
			res.sendRedirect(req.getContextPath() + "/admin");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		try {
			// ===== SAFE ID PARSE =====
			String idParam = req.getParameter("reservationId");
			if (idParam == null || idParam.isBlank()) {
				throw new IllegalArgumentException("予約IDが不正です");
			}

			int reservationId = Integer.parseInt(idParam);

			ReservationDao dao = new ReservationDao();
			Reservation r = dao.findById(reservationId);

			if (r == null) {
				throw new IllegalArgumentException("予約が存在しません");
			}

			// ===== BASIC INFO =====
			r.setReservationDate(LocalDate.parse(req.getParameter("date")));
			r.setStartTime(LocalTime.parse(req.getParameter("startTime")));
			r.setEndTime(r.getStartTime().plusMinutes(120));

			r.setAdultCount(Integer.parseInt(req.getParameter("adult")));
			r.setChildCount(Integer.parseInt(req.getParameter("child")));

			r.setCustomerName(req.getParameter("customerName")); // ✅ FIXED
			r.setCustomerEmail(req.getParameter("customerEmail")); // ✅ FIXED
			r.setCustomerPhone(req.getParameter("phone"));

			// ===== TABLES =====
			String[] tables = req.getParameterValues("tableIds");
			if (tables == null || tables.length == 0) {
				throw new IllegalArgumentException("テーブルを選択してください");
			}
			r.setTableIds(Arrays.asList(tables));

			// ===== COURSE =====
			String courseParam = req.getParameter("courseId");
			if (courseParam == null || courseParam.equals("0")) {
				r.setCourseId(null);
			} else {
				r.setCourseId(Integer.parseInt(courseParam));
			}
			boolean conflict = dao.hasTimeConflictForEdit(
					r.getReservationDate(),
					r.getStartTime(),
					r.getEndTime(),
					r.getTableIds(),
					r.getReservationId());

			if (conflict) {
				// keep edited reservation in session
				req.getSession().setAttribute("pendingEditReservation", r);

				req.setAttribute("errorMessage",
						"選択した時間帯・テーブルは既に予約があります。<br>このまま上書きしますか？");
				req.setAttribute("forceAllowed", true);

				req.getRequestDispatcher("/Admin/error.jsp")
						.forward(req, res);
				return;
			}

			// no conflict → normal update
			dao.update(r);

			String backDate = r.getReservationDate().toString();

			if (backDate != null && !backDate.isBlank()) {
				res.sendRedirect(req.getContextPath()
						+ "/adminreservation/list?date=" + backDate);
			} else {
				res.sendRedirect(req.getContextPath() + "/admin");
			}

		} catch (Exception e) {
			e.printStackTrace();

			try {
				String idParam = req.getParameter("reservationId");
				if (idParam != null && !idParam.isBlank()) {
					int id = Integer.parseInt(idParam);

					ReservationDao dao = new ReservationDao();
					MenuDao mdao = new MenuDao();

					req.setAttribute("res", dao.findById(id));
					req.setAttribute("courseList", mdao.findAll());
				}

				req.setAttribute("error", e.getMessage());
				req.getRequestDispatcher("/Admin/edit.jsp").forward(req, res);

			} catch (Exception ex) {
				res.sendRedirect(req.getContextPath() + "/admin");
			}
		}
	}
}
