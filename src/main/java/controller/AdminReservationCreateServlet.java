package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;
import service.Constants;

@WebServlet("/admin/reserve")
public class AdminReservationCreateServlet extends HttpServlet {

	private final ReservationDao dao = new ReservationDao();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Reservation res = null;

		try {
			String dateStr = request.getParameter("date");
			String startStr = request.getParameter("startTime");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String courseIdStr = request.getParameter("courseId");
			String[] tableIdsArray = request.getParameterValues("tableIds");

			int adultCount = Integer.parseInt(request.getParameter("adult"));
			int childCount = Integer.parseInt(request.getParameter("child"));

			res = new Reservation();
			res.setCustomerName(name);
			res.setCustomerEmail(email);
			res.setCustomerPhone(phone);

			if (courseIdStr != null && !courseIdStr.isBlank()) {
				int courseId = Integer.parseInt(courseIdStr);
				if (courseId > 0) {
					res.setCourseId(courseId);
				}
			}

			LocalDate date = LocalDate.parse(dateStr);
			LocalTime startTime = LocalTime.parse(startStr);

			res.setReservationDate(date);
			res.setStartTime(startTime);
			res.setEndTime(startTime.plusMinutes(Constants.DURATION_MINUTES));
			res.setAdultCount(adultCount);
			res.setChildCount(childCount);
			res.setStatus("RESERVED");
			res.setReservationType("ADMIN");

			if (tableIdsArray == null || tableIdsArray.length == 0) {
				throw new IllegalArgumentException("テーブルを選択してください");
			}
			res.setTableIds(Arrays.asList(tableIdsArray));

			// ✅ TABLE CONFLICT → FORCE FLOW
			if (dao.hasTimeConflict(
					res.getReservationDate(),
					res.getStartTime(),
					res.getEndTime(),
					res.getTableIds())) {

				request.getSession().setAttribute("pendingReservation", res);

				request.setAttribute("errorMessage",
						"選択した時間帯・テーブルは既に予約があります。<br>このまま予約を続行しますか？");
				request.setAttribute("forceAllowed", true);

				request.getRequestDispatcher("/Admin/error.jsp")
						.forward(request, response);
				return;
			}

			// ✅ NORMAL INSERT
			dao.insertCustomerReservation(res);

			response.sendRedirect(
					request.getContextPath()
							+ "/adminreservation/list?date=" + dateStr);

		} catch (Exception e) {

			e.printStackTrace();

			String message = e.getMessage();
			if (message == null || message.isBlank()) {
				message = "予約登録中に予期しないエラーが発生しました";
			}

			request.setAttribute("errorMessage", message);
			request.setAttribute("forceAllowed", false);

			request.getRequestDispatcher("/Admin/error.jsp")
					.forward(request, response);
		}
	}
}
