package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.CustomerService;

/**
 * Servlet implementation class Registerationservlet
 */
@WebServlet("/Registerationservlet")
public class Registerationservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Registerationservlet() {
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
		response.setContentType("text/html");
		String username = request.getParameter("username");
		String furikana = request.getParameter("furikana");
		String usermail = request.getParameter("usermail");
		String usertel = request.getParameter("usertel");
		String userpass = request.getParameter("userpass");
		String repassword = request.getParameter("repassword");

		CustomerService cs = new CustomerService();
		List<String> errors = new ArrayList<>();

		// ▼ Name required
		if (username == null || username.isEmpty()) {
			errors.add("Name is required.");
		}

		// ▼ Furikana must be 全角カタカナ
		if (!cs.isValidKanaName(furikana)) {
			errors.add("Furikana must be full-width Katakana.");
		}

		// ▼ Email required
		if (usermail == null || usermail.isEmpty()) {
			errors.add("Email is required.");
		}

		// ▼ Phone required
		if (usertel == null || usertel.isEmpty()) {
			errors.add("Phone number is required.");
		}

		// ▼ Password strength
		if (!cs.isValidPassword(userpass)) {
			errors.add("Password must be at least 8 characters and contain a number.");
		}

		// ▼ Passwords must match
		if (!cs.passwordsMatch(userpass, repassword)) {
			errors.add("Password and re-entered password do not match.");
		}

		// ------------------------------
		// If there are errors → return to JSP
		// ------------------------------
		if (!errors.isEmpty()) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("registerForm.jsp").forward(request, response);
			return;
		}
	}

}
