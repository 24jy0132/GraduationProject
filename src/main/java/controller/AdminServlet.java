package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateParam  = request.getParameter("date");
        String yearParam  = request.getParameter("year");
        String monthParam = request.getParameter("month");

        LocalDate selectedDate;
        YearMonth ym;

        if (yearParam != null && monthParam != null) {
            ym = YearMonth.of(Integer.parseInt(yearParam),
                              Integer.parseInt(monthParam));
            selectedDate = ym.atDay(1);
        }
        else if (dateParam != null) {
            selectedDate = LocalDate.parse(dateParam);
            ym = YearMonth.from(selectedDate);
        }
        else {
            selectedDate = LocalDate.now();
            ym = YearMonth.from(selectedDate);
        }

        ReservationDao dao = new ReservationDao();

        List<Reservation> list = dao.findByDatelist(selectedDate);
        Map<LocalDate,Integer> monthCount = dao.countByMonth(ym);

        request.setAttribute("date", selectedDate);
        request.setAttribute("ym", ym);
        request.setAttribute("list", list);
        request.setAttribute("monthCount", monthCount);

        request.getRequestDispatcher("/reservation/admin.jsp")
               .forward(request, response);
    }
}