package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.MenuDao;
import model.Menu;

/**
 * Servlet implementation class Menucontrollers
 */
@WebServlet("/Menucontrollers")
public class Menucontrollers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Menucontrollers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		MenuDao md = new MenuDao();
		List<Menu>getMenu = md.getAllItem();
		
		HttpSession session = request.getSession();
		if(getMenu!=null) {
			  for (Menu m : getMenu) {
		            System.out.println("Loaded: " + m.getMenuname() + " | category=" + m.getCategory());
		        }
			session.setAttribute("menu", getMenu);
			request.getRequestDispatcher("menu.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
