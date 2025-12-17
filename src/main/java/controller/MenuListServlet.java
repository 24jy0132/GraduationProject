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

@WebServlet("/MenuListServlet")
public class MenuListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public MenuListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		MenuService menuservice = new MenuService();
		List<Menu> menus = menuservice.getAllMenus();
		List<Menu> surveyMenus = menuservice.getSurveyMenus();
		List<Menu> newMenus = menuservice.getNewMenus();

		
		request.setAttribute("menus", menus);
		request.setAttribute("surveyMenus", surveyMenus);
		request.setAttribute("newMenus", newMenus);

		RequestDispatcher rd = request.getRequestDispatcher("/Menulist.jsp");
		rd.forward(request, response);
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
