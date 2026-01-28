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
* Servlet implementation class AdminSurveyCreateServlet
*/
@WebServlet("/AdminSurveyCreateServlet")
public class AdminSurveyCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
   /**
    * @see HttpServlet#HttpServlet()
    */
   public AdminSurveyCreateServlet() {
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
		List<Menu> notSurveyMenu = service.getNotSurveyMenus();
		
		request.setAttribute("notSurveyMenu", notSurveyMenu);
		RequestDispatcher rd = request.getRequestDispatcher("staffSurveyCreate.jsp");
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



