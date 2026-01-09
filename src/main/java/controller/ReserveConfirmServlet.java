package controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.MenuDao;
import model.Menu;
import model.Reservation;

@WebServlet("/reserve/confirm")
public class ReserveConfirmServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		Reservation r = (Reservation) req.getSession().getAttribute("pendingReservation");
		if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
			res.sendRedirect(req.getContextPath() + "/reserve");
			return;
		}
		Menu course = null;

		if ("COURSE".equals(r.getReservationType()) && r.getCourseId() != null) {
		    MenuDao menuDao = new MenuDao();
		    try {
				course = menuDao.findById1(r.getCourseId());
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		}

		req.setAttribute("course", course);


		req.getRequestDispatcher("/confirm.jsp").forward(req, res);
	}
}
