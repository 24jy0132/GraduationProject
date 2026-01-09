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

@WebServlet("/admin/edit")
public class AdminEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            ReservationDao dao = new ReservationDao();
            Reservation r = dao.findById(id);   // 🔴 MUST EXIST

            req.setAttribute("reservation", r);
            req.getRequestDispatcher("/Admin/edit.jsp")
               .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int reservationId =
                Integer.parseInt(req.getParameter("reservationId"));

            LocalDate date =
                LocalDate.parse(req.getParameter("date"));

            LocalTime startTime =
                LocalTime.parse(req.getParameter("startTime"));

            // ⏰ end = start + 2 hours
            LocalTime endTime =
                startTime.plusMinutes(Constants.DURATION_MINUTES);

            int adult = Integer.parseInt(req.getParameter("adult"));
            int child = Integer.parseInt(req.getParameter("child"));

            String name = req.getParameter("customerName");
            String email = req.getParameter("customerEmail");

            String[] tableIds =
                req.getParameterValues("tableIds");

            Reservation r = new Reservation();
            r.setReservationId(reservationId);
            r.setReservationDate(date);
            r.setStartTime(startTime);
            r.setEndTime(endTime);
            r.setAdultCount(adult);
            r.setChildCount(child);
            r.setCustomerName(name);
            r.setCustomerEmail(email);
            r.setTableIds(Arrays.asList(tableIds));

            ReservationDao dao = new ReservationDao();
            dao.update(r);

            res.sendRedirect(req.getContextPath() + "/admin");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/Admin/edit.jsp")
               .forward(req, res);
        }
    }
}
