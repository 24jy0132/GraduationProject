package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Menu;
import service.MenuService;

/**
 * Servlet implementation class AdminMenuServlet
 */
@WebServlet("/AdminMenuServlet")
public class AdminMenuEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMenuEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		MenuService menuService = new MenuService();
		List<Menu> allMenus = menuService.getAllMenus();
		request.setAttribute("allMenus", allMenus);
		
		RequestDispatcher rd = request.getRequestDispatcher("/staffMenuEdit.jsp");

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String menuName = request.getParameter("menuName");
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");
		String imagePath = request.getParameter("imagePath");
		
		
		int isSurveyTarget = Integer.parseInt(request.getParameter("isSurveyTarget"));
		int surveyId = 1;
		int isNew = 1;
		MenuService menuService = new MenuService();
		menuService.insertNewMenu(menuName,description,price,category,imagePath,isSurveyTarget,surveyId,isNew);


		
		
	}

}
