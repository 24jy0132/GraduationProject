package controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;

@WebServlet("/admin/delete")
public class AdminDeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		// ===== 1️⃣ Validate reservation ID =====
		String idParam = req.getParameter("id");
		if (idParam == null || idParam.isBlank()) {
			res.sendRedirect(req.getContextPath() + "/adminreservation/list");
			return;
		}

		int reservationId;
		try {
			reservationId = Integer.parseInt(idParam);
		} catch (NumberFormatException e) {
			res.sendRedirect(req.getContextPath() + "/adminreservation/list");
			return;
		}

		// ===== 2️⃣ Delete reservation =====
		ReservationDao dao = new ReservationDao();
		dao.delete(reservationId);

		// ===== 3️⃣ Redirect back correctly =====
		String backDate = req.getParameter("date");
		String all = req.getParameter("all");

		// 🔁 Priority:
		// 1. all=true → 全件表示
		// 2. date=YYYY-MM-DD → same date list
		// 3. fallback → list (today)

		if ("true".equals(all)) {
			res.sendRedirect(req.getContextPath()
					+ "/adminreservation/list?all=true");
		} else if (backDate != null && !backDate.isBlank()) {
			res.sendRedirect(req.getContextPath()
					+ "/adminreservation/list?date=" + backDate);
		} else {
			res.sendRedirect(req.getContextPath()
					+ "/adminreservation/list");
		}
	}
}
