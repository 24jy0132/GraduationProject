package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

/**
 * Servlet implementation class AdminEditForceServlet
 */
@WebServlet("/admin/edit/force")
public class AdminEditForceServlet extends HttpServlet {

    private final ReservationDao dao = new ReservationDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        Reservation r = (Reservation) req.getSession()
                .getAttribute("pendingEditReservation");

        if (r == null) {
            res.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        try {
            // 1️⃣ cancel other reservations
            dao.cancelConflictingReservationsForEdit(
                    r.getReservationDate(),
                    r.getStartTime(),
                    r.getEndTime(),
                    r.getTableIds(),
                    r.getReservationId()
            );

            // 2️⃣ update this reservation
            dao.update(r);

            // 3️⃣ cleanup
            req.getSession().removeAttribute("pendingEditReservation");

            res.sendRedirect(req.getContextPath()
                    + "/adminreservation/list?date=" + r.getReservationDate());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "強制更新に失敗しました");
            req.getRequestDispatcher("/Admin/error.jsp")
               .forward(req, res);
        }
    }
}

