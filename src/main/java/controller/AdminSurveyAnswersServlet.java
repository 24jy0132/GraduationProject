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
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSurveyAnswersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		MenuService service = new MenuService();
		
		int menuId = Integer.parseInt(request.getParameter("menuId"));
		Menu menu = service.getMenuById(menuId);
		List<Menu> surveyMenus = service.getSurveyMenus();
		
		
		SurveyService service2 = new SurveyService();
		
		int questionId = 4;
		Map<Integer, Map<String,Integer>> tasteSummary = service2.getTasteSummaryForMenus(surveyMenus);
		Map<Integer, Map<String,Integer>> volumeSummary = service2.getVolumeSummaryForMenus(surveyMenus);
		Map<Integer, Map<String,Integer>> priceSummary = service2.getPriceSummaryForMenus(surveyMenus);
		List<String> comments = service2.getSurveyComments(questionId,menuId);
		
		request.setAttribute("menu", menu);
		request.setAttribute("tasteSummary", tasteSummary);
		request.setAttribute("volumeSummary", volumeSummary);
		request.setAttribute("priceSummary", priceSummary);
		request.setAttribute("comments", comments);


		RequestDispatcher rd = request.getRequestDispatcher("staffSurveyAnswers.jsp");
		 rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

