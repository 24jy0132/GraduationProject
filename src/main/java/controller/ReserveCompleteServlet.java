package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;
import service.ReserveRegistration_MailSender;
@WebServlet("/reserve/complete")
public class ReserveCompleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Reservation r =
            (Reservation) session.getAttribute("pendingReservation");

        if (r == null) {
            res.sendRedirect(req.getContextPath() + "/reserve");
            return;
        }

        try {
            new ReservationDao().insertCustomerReservation(r);
            boolean mailFailed = false;

            // ★ 追加：メール送信
          try {
        	  ReserveRegistration_MailSender.send(r.getCustomerEmail(), r);
            } catch (Exception mailEx) {
                mailEx.printStackTrace();
                mailFailed = true;
            }

            session.removeAttribute("pendingReservation");
            res.sendRedirect(req.getContextPath() + "/complete.jsp");

        } catch (Exception e) {
            req.setAttribute("error", "予約登録に失敗しました");
            req.getRequestDispatcher("/confirm.jsp").forward(req, res);
        }
    }
}

