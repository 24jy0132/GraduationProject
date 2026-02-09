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
            String dateStr = request.getParameter("date");
            String startStr = request.getParameter("startTime");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String courseIdStr = request.getParameter("courseId");
            String[] tableIdsArray = request.getParameterValues("tableIds");

            int adultCount = Integer.parseInt(request.getParameter("adult"));
            int childCount = Integer.parseInt(request.getParameter("child"));

            Reservation res = new Reservation();
            res.setCustomerName(name);
            res.setCustomerEmail(email);
            res.setCustomerPhone(phone);

            if (courseIdStr != null && !courseIdStr.isEmpty()) {
                int courseId = Integer.parseInt(courseIdStr);
                if (courseId > 0) {
                    res.setCourseId(courseId);
                }
            }

            res.setReservationDate(LocalDate.parse(dateStr));

            LocalTime startTime = LocalTime.parse(startStr);
            res.setStartTime(startTime);
            res.setEndTime(startTime.plusMinutes(Constants.DURATION_MINUTES));

            res.setAdultCount(adultCount);
            res.setChildCount(childCount);
            res.setStatus("RESERVED");
            res.setReservationType("ADMIN");

            if (tableIdsArray != null) {
                res.setTableIds(Arrays.asList(tableIdsArray));
            }

            // 🔴 TIME CONFLICT CHECK
            if (dao.hasTimeConflict(
                    res.getReservationDate(),
                    res.getStartTime(),
                    res.getEndTime(),
                    res.getTableIds())) {

                request.setAttribute("error", "選択した時間帯・テーブルは既に予約があります。");
                request.getRequestDispatcher("/Admin/reserve.jsp")
                       .forward(request, response);
                return;
            }

            dao.insertCustomerReservation(res);

            response.sendRedirect(
                request.getContextPath() + "/adminreservation/list?date=" + dateStr);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "予約登録中にエラーが発生しました。");
            request.getRequestDispatcher("/Admin/reserve.jsp")
                   .forward(request, response);
        }
    }
}
