package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import model.Reservation;
import service.Constants;
@WebServlet("/reserve/input")
public class ReserveInputServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession();

            LocalDate date = LocalDate.parse(req.getParameter("date"));
            LocalTime start = LocalTime.parse(req.getParameter("startTime"));
            LocalTime end = start.plusMinutes(Constants.DURATION_MINUTES);

            int adult = Integer.parseInt(req.getParameter("adult"));
            int child = Integer.parseInt(req.getParameter("child"));

            if (adult + child > 6) {
                throw new IllegalArgumentException("6名を超える場合はお電話ください");
            }

            Reservation r = new Reservation();
            r.setReservationDate(date);
            r.setStartTime(start);
            r.setEndTime(end);
            r.setAdultCount(adult);
            r.setChildCount(child);
            r.setCustomerName(req.getParameter("name"));
            r.setCustomerEmail(req.getParameter("email"));

            Customer loginCustomer =
                (Customer) session.getAttribute("loginCustomer");
            if (loginCustomer != null) {
                r.setCustomerId(loginCustomer.getUserId());
                r.setCustomerName(loginCustomer.getName());
                r.setCustomerEmail(loginCustomer.getEmail());
            }

            session.setAttribute("pendingReservation", r);

            res.sendRedirect(req.getContextPath() + "/reserve/table");

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher(req.getContextPath() + "/reservationForm.jsp").forward(req, res);
        }
    }
}
