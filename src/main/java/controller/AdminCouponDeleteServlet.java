package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CouponDao;

/**
 * Servlet implementation class CouponDeleteServlet
 */
@WebServlet("/admin/coupon/delete")
public class AdminCouponDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int couponId = Integer.parseInt(request.getParameter("id"));

        try {
            CouponDao dao = new CouponDao();
            dao.delete(couponId);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(
            request.getContextPath() + "/admin/coupon/list");
    }
}


