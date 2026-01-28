package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDao;
import model.Customer;

@WebServlet("/member/delete")
public class MemberDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            CustomerDao dao = new CustomerDao();
            dao.delete(customer.getUserId());

            // 🔴 important: logout completely
            session.invalidate();

            res.sendRedirect(req.getContextPath() + "/index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "退会処理に失敗しました。");
            req.getRequestDispatcher("/member_edit.jsp")
               .forward(req, res);
        }
    }
}
