package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.MenuService;

/**
 * Servlet implementation class AdminMenuUpdateServlet
 */
@WebServlet("/AdminMenuUpdateServlet")
public class AdminMenuUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMenuUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		int menuId = Integer.parseInt(request.getParameter("menuId"));
        String menuName = request.getParameter("menuName");
        String category = request.getParameter("category");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");

        MenuService service = new MenuService();
        service.updateMenu(menuId, menuName, category, price, description);

        // 一覧画面へ戻る（編集モード解除）
        response.sendRedirect("AdminMenuEditServlet");
	}

}