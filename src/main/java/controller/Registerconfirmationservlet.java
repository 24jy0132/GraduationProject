package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import service.CustomerService;

/**
 * Servlet implementation class Registerconfirmationservlet
 */
@WebServlet("/Registerconfirmationservlet")
public class Registerconfirmationservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Registerconfirmationservlet() {
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
		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String furikana = request.getParameter("furikana");
		String usermail = request.getParameter("usermail");
		String usertel = request.getParameter("usertel");
		String userpass = request.getParameter("userpass");
		String repassword = request.getParameter("repassword");

		CustomerService cs = new CustomerService();
		List<String> errors = new ArrayList<>();

		// Validation
		if (username == null || username.isBlank())
			errors.add("Name is required.");
		if (furikana == null || !cs.isValidKanaName(furikana))
			errors.add("Furikana must be full-width Katakana.");
		if (usermail == null || usermail.isBlank())
			errors.add("Email is required.");
		if (!cs.mailexists(usermail)) 
			errors.add("Email already exists");
		if (usertel == null || usertel.isBlank())
			errors.add("Phone is required.");
		if (!cs.isValidPassword(userpass))
			errors.add("Password must be at least 8 chars and contain a number.");
		if (!cs.passwordsMatch(userpass, repassword))
			errors.add("Passwords do not match.");

		if (!errors.isEmpty()) {
			request.setAttribute("errors", errors);
			request.setAttribute("username", username);
			request.setAttribute("furikana", furikana);
			request.setAttribute("usermail", usermail);
			request.setAttribute("usertel", usertel);
			request.getRequestDispatcher("registerForm.jsp").forward(request, response);
			return;
		}

		// Save user temporarily in session
		HttpSession session = request.getSession();
		Customer temp = new Customer(username, furikana, usermail, usertel, userpass);
		session.setAttribute("tempUser", temp);

		// Forward to confirmation page
		request.getRequestDispatcher("registerConfirm.jsp").forward(request, response);

	}

}
