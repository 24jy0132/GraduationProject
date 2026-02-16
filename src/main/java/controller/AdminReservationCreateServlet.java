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

		try {

			// ==============================
			// 1. GET PARAMETERS
			// ==============================

			String dateStr = request.getParameter("date");
			String startStr = request.getParameter("startTime");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String courseIdStr = request.getParameter("courseId");
			String[] tableIdsArray = request.getParameterValues("tableIds");

			int adultCount = Integer.parseInt(request.getParameter("adult"));
			int childCount = Integer.parseInt(request.getParameter("child"));

			// ==============================
			// 2. BASIC VALIDATION
			// ==============================

			if (name == null || name.isBlank()) {
				throw new IllegalArgumentException("お客様名を入力してください。");
			}

			if (phone == null || phone.isBlank()) {
				throw new IllegalArgumentException("電話番号を入力してください。");
			}

			// ✅ STRICT PHONE VALIDATION
			// Only 10-11 half-width digits allowed
			if (!phone.matches("^[0-9]{10,11}$")) {
				throw new IllegalArgumentException(
						"電話番号は半角数字10〜11桁で入力してください（ハイフン・スペース不可）。");
			}

			// Optional Email Validation
			if (email != null && !email.isBlank()) {
				if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
					throw new IllegalArgumentException("メールアドレスの形式が正しくありません。");
				}
			}

			if (tableIdsArray == null || tableIdsArray.length == 0) {
				throw new IllegalArgumentException("テーブルを選択してください。");
			}

			// ==============================
			// 3. BUILD RESERVATION OBJECT
			// ==============================

			Reservation res = new Reservation();

			res.setCustomerName(name.trim());
			res.setCustomerEmail(email);
			res.setCustomerPhone(phone);

			LocalDate date = LocalDate.parse(dateStr);
			LocalTime startTime = LocalTime.parse(startStr);

			res.setReservationDate(date);
			res.setStartTime(startTime);
			res.setEndTime(startTime.plusMinutes(Constants.DURATION_MINUTES));

			res.setAdultCount(adultCount);
			res.setChildCount(childCount);
			res.setStatus("RESERVED");
			res.setReservationType("ADMIN");

			res.setTableIds(Arrays.asList(tableIdsArray));

			if (courseIdStr != null && !courseIdStr.isBlank()) {
				int courseId = Integer.parseInt(courseIdStr);
				if (courseId > 0) {
					res.setCourseId(courseId);
				}
			}

			// ==============================
			// 4. TIME CONFLICT CHECK
			// ==============================

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

			// ==============================
			// 5. INSERT
			// ==============================

			dao.insertCustomerReservation(res);

			response.sendRedirect(
					request.getContextPath()
							+ "/adminreservation/list?date=" + dateStr);

		} catch (Exception e) {

			e.printStackTrace();

			String message = e.getMessage();

			if (message == null || message.isBlank()) {
				message = "予約登録中に予期しないエラーが発生しました。";
			}

			request.setAttribute("errorMessage", message);
			request.setAttribute("forceAllowed", false);

			request.getRequestDispatcher("/Admin/error.jsp")
					.forward(request, response);
		}
	}
}
