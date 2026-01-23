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

@WebServlet("/coupons")
public class MemberCouponListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        try {
            CouponDao dao = new CouponDao();
            // Fetch every coupon from the database
            List<Coupon> allCoupons = dao.findAll(); 
            req.setAttribute("allCoupons", allCoupons);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Forward to the gallery page
        req.getRequestDispatcher("/couponGallery.jsp").forward(req, res);
    }
}