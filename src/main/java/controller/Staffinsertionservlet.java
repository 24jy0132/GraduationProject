package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StaffDao;
import model.Staff;

/**
 * Servlet implementation class Staffinsertionservlet
 */
@WebServlet("/Staffinsertionservlet")
public class Staffinsertionservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Staffinsertionservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Staff temp = (Staff) session.getAttribute("tempStaff");

		if (temp == null) {
			response.sendRedirect("Admin/staffregisteration.jsp");
			return;
		}

		StaffDao sd = new StaffDao();

		int result = sd.insert(temp);

		if (result == 1) {
			session.removeAttribute("tempUser");
			session.setAttribute("message", "従業員登録完了しました。");
			request.getRequestDispatcher("Admin/staffregisterComplete.jsp").forward(request, response);
		} else {
			request.setAttribute("errors", List.of("Database error, registration failed."));
			request.getRequestDispatcher("Admin/staffregisteration.jsp").forward(request, response);
		}

	}

}
