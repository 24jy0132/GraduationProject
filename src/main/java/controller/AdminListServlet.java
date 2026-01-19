package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;
import model.Reservation;

@WebServlet("/admin/list")
public class AdminListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ReservationDao dao = new ReservationDao();
        List<Reservation> list = dao.findAll();
  

        req.setAttribute("list", list);
        req.getRequestDispatcher("/reservation/adminList.jsp")
           .forward(req, res);
    }
}