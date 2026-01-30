package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import dao.CustomerDao;

@WebServlet("/PointServlet")
public class PointServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        response.setContentType("application/json; charset=UTF-8");

        if (customer == null) {
            response.getWriter().write("{\"point\":0}");
            return;
        }

        CustomerDao dao = new CustomerDao();
        int latestPoint = dao.getPointByUserId(customer.getUserId());

        // 🔥 update session value so JSP stays in sync
        customer.setPoint(latestPoint);
        session.setAttribute("customer", customer);

        response.getWriter().write("{\"point\":" + latestPoint + "}");
    }
}
