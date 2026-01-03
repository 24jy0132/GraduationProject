package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.SurveyAnswerDao;
import model.Customer;
import model.Menu;      // ✅ correct
import service.MenuService;

@WebServlet("/SurveyServlet")
public class SurveyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SurveyServlet() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer)session.getAttribute("customer");
		SurveyAnswerDao sad = new SurveyAnswerDao();
		int menuId =Integer.parseInt(request.getParameter("menuId"));
		
		if(customer == null) {
			response.sendRedirect("login_required.jsp");
			
		}else if(sad.alreadyAnswered(customer.getUserId(), menuId)){
			response.sendRedirect("alreadyAnswered.jsp");
		}else {
			MenuService menuservice = new MenuService();
			Menu menu = menuservice.getMenuById(menuId);
			
			request.setAttribute("menu", menu);
			
			RequestDispatcher rd = request.getRequestDispatcher("/survey.jsp");
	        rd.forward(request, response);
		}
		
		
		
		
		
		
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
