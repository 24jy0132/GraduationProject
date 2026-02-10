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
			errors.add("名前の入力は必須です");
		}

		// ▼ Furikana must be 全角カタカナ
		if (!cs.isValidKanaName(furikana)) {
			errors.add("フリガナは全角カタカナで入力してください。");
		}

		// ▼ Email required
		if (usermail == null || usermail.isEmpty()) {
			errors.add("メールアドレスの入力は必須です");
		}

		// ▼ Phone required
		if (usertel == null || usertel.isEmpty()) {
			errors.add("電話番号の入力は必須です");
		}

		// ▼ Password strength
		if (!cs.isValidPassword(userpass)) {
			errors.add("パスワードは8文字以上で、少なくとも1つの数字を含めてください。");
		}

		// ▼ Passwords must match
		if (!cs.passwordsMatch(userpass, repassword)) {
			errors.add("パスワードと確認用パスワードが一致していません。");
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
