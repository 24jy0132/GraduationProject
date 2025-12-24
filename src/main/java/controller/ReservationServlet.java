package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

@WebServlet("/reserve")
public class ReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        LocalDate date = LocalDate.parse(req.getParameter("date"));
        LocalTime time = LocalTime.parse(req.getParameter("time"));

        if (date.isBefore(LocalDate.now())
            || (date.equals(LocalDate.now()) && time.isBefore(LocalTime.now()))) {
            res.sendRedirect(
              req.getContextPath()
              + "/reservation/userReservationForm.jsp?error=time"
            );
            return;
        }

        int adult = Integer.parseInt(req.getParameter("adult"));
        int child = Integer.parseInt(req.getParameter("child"));

        ReservationDao dao = new ReservationDao();

        try {
            String table =
              dao.assignTable(date, time, adult + child);

            if (table == null) {
                dao.close();
                res.sendRedirect(
                  req.getContextPath()
                  + "/reservation/userReservationForm.jsp?error=full"
                );
                return;
            }

            Reservation r = new Reservation();
            r.setReservationDate(date);
            r.setStartTime(time);
            r.setAdultCount(adult);
            r.setChildCount(child);
            r.setTableId(table);
            r.setCustomerName(req.getParameter("name"));
            r.setCustomerEmail(req.getParameter("email"));

            dao.insert(r);
            dao.close();

            res.sendRedirect(
              req.getContextPath()
              + "/reservation/success.jsp"
            );

        } catch (Exception e) {
            e.printStackTrace();
            dao.close();
        }
    }
}