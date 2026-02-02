package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import service.SurveyService;

@WebServlet("/SurveyDoneServlet")
public class SurveyDoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		int menuId = Integer.parseInt(request.getParameter("menuId"));
		String taste = request.getParameter("taste");
		String volume = request.getParameter("volume");
		String price = request.getParameter("price");
		String comment = request.getParameter("comment");

		int surveyId = 1;

		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("customer");

		if (customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int userId = customer.getUserId();

		// ✅ DB logic
		SurveyService service = new SurveyService();
		service.submitSurvey(surveyId, menuId, userId, taste, volume, price, comment);

		// ✅ SESSION UPDATE (THIS WAS MISSING)
		customer.setPoint(customer.getPoint() + 10);
		session.setAttribute("customer", customer);

		// ✅ for animation / UI feedback
		session.setAttribute("earnedPoint", 10);

		response.sendRedirect("SurveyDone.jsp");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("MenuListServlet");
	}
}
