package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Menu;
import service.MenuService;
import service.SurveyService;

/**
 * Servlet implementation class AdminSurveyAnswersServlet
 */
@WebServlet("/AdminSurveyAnswersServlet")
public class AdminSurveyAnswersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminSurveyAnswersServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. GET PARAMETER SAFELY (Fixes the 500 Error)
		String menuIdStr = request.getParameter("menuId");

		// If ID is missing, go back to the list page instead of crashing
		if (menuIdStr == null || menuIdStr.isEmpty()) {
			response.sendRedirect("AdminMenuServlet"); // Adjust this to your actual list servlet URL
			return;
		}

		int menuId = 0;
		try {
			menuId = Integer.parseInt(menuIdStr);
		} catch (NumberFormatException e) {
			// If ID is not a number (e.g. ?menuId=abc), go back
			response.sendRedirect("AdminMenuServlet");
			return;
		}

		// 2. LOGIC (Only runs if ID is valid)
		MenuService service = new MenuService();
		Menu menu = service.getMenuById(menuId);

		// If menu not found in DB
		if (menu == null) {
			response.sendRedirect("AdminMenuServlet");
			return;
		}

		List<Menu> surveyMenus = service.getSurveyMenus();

		SurveyService service2 = new SurveyService();

		int questionId = 4; // Assuming 4 is the ID for free text comments

		Map<Integer, Map<String, Integer>> tasteSummary = service2.getTasteSummaryForMenus(surveyMenus);
		Map<Integer, Map<String, Integer>> volumeSummary = service2.getVolumeSummaryForMenus(surveyMenus);
		Map<Integer, Map<String, Integer>> priceSummary = service2.getPriceSummaryForMenus(surveyMenus);
		List<String> comments = service2.getSurveyComments(questionId, menuId);

		// 3. SET ATTRIBUTES
		request.setAttribute("menu", menu);
		request.setAttribute("tasteSummary", tasteSummary);
		request.setAttribute("volumeSummary", volumeSummary);
		request.setAttribute("priceSummary", priceSummary);
		request.setAttribute("comments", comments);

		// 4. FORWARD (Updated to match the JSP file we created: staffSurveyView.jsp)
		// Make sure the file name matches exactly what you have in your folder!
		RequestDispatcher rd = request.getRequestDispatcher("staffSurveyAnswers.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}