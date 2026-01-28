package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;

@WebServlet("/member/profile")
public class MemberProfileServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		Customer customer = (Customer) session.getAttribute("customer");

		if (customer == null) {
			res.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		// later you can add: coupon usage status here
		req.getRequestDispatcher("/member_profile.jsp")
				.forward(req, res);
	}
}
