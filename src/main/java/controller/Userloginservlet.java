package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDao;
import model.Customer;

/**
 * Servlet implementation class Userloginservlet
 */
@WebServlet("/Userloginservlet")
public class Userloginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Userloginservlet() {
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
		String mail = request.getParameter("usermail");
		String password = request.getParameter("userpassword");

		CustomerDao cd = new CustomerDao();
		Customer customer = cd.findByEmailAndPassword(mail, password);

		HttpSession session = request.getSession();

		if (customer != null) {
			session.setAttribute("customer", customer);
			request.getRequestDispatcher("member_index.jsp").forward(request, response);
		} else {
			request.setAttribute("error", "メールアドレスまたはパスワードが正しくありません");
		    request.getRequestDispatcher("login.jsp")
		           .forward(request, response);
		}
	}

}
