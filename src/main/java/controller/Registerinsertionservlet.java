package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDao;
import model.Customer;

/**
 * Servlet implementation class registerinsertionservlet
 */
@WebServlet("/Registerinsertionservlet")
public class Registerinsertionservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Registerinsertionservlet() {
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
		HttpSession session = request.getSession();
		Customer temp = (Customer) session.getAttribute("tempUser");

		if (temp == null) {
			response.sendRedirect("registerForm.jsp");
			return;
		}

		CustomerDao dao = new CustomerDao();

		System.out.println("Inserting user: " + temp.getName() + ", " + temp.getEmail());

		int result = dao.insert(temp);

		if (result == 1) {
			session.removeAttribute("tempUser");
			session.setAttribute("message", "Registered successfully!");
			request.getRequestDispatcher("registerComplete.jsp").forward(request, response);
		} else {
			request.setAttribute("errors", List.of("Database error, registration failed."));
			request.getRequestDispatcher("registerForm.jsp").forward(request, response);
		}
	}

}
