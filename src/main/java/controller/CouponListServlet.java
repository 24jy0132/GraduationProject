package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CouponDao;
import model.Coupon;

/**
 * Servlet implementation class CouponListServlet
 */
@WebServlet("/admin/coupon/list")
public class CouponListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            List<Coupon> coupons = new CouponDao().findAll();
            req.setAttribute("coupons", coupons);
            req.getRequestDispatcher("/Admin/couponList.jsp")
               .forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

