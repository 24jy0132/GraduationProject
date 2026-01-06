package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Menu;
import service.MenuService;
import service.SurveyService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class StaffMenuListServlet
 */
@WebServlet("/StaffMenuListServlet")
public class StaffMenuListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StaffMenuListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		MenuService menuservice = new MenuService();
		
	    request.setAttribute("menus", menuservice.getAllMenus());
	    request.setAttribute("surveyMenus", menuservice.getSurveyMenus());
	    request.setAttribute("newMenus", menuservice.getNewMenus());
	    request.setAttribute("mainMenus", menuservice.getMainMenus());
	    request.setAttribute("alaCarteMenus", menuservice.getAlaCarteMenus());
	    request.setAttribute("saladSoup", menuservice.getSaladSoup());
	    request.setAttribute("drinks", menuservice.getDrinks());
	    
	    List<Menu> surveyMenus = menuservice.getSurveyMenus();

	    SurveyService surveyService = new SurveyService();
	    Map<Integer, Map<String, Integer>> tasteSummary = surveyService.getTasteSummaryForMenus(surveyMenus);
	    request.setAttribute("tasteSummary",tasteSummary );

	    
	    RequestDispatcher rd = request.getRequestDispatcher("/staffMenu.jsp");
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
