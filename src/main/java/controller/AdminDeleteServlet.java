package controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ReservationDao;

/**
 * Servlet implementation class AdminDeleteServlet
 */
@WebServlet("/admin/delete")
public class AdminDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        ReservationDao dao = new ReservationDao();
        dao.delete(id);

        res.sendRedirect(req.getContextPath() + "/admin");
    }
}