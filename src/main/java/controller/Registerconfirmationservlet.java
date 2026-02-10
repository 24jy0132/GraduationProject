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
		int userpoint=0;

		CustomerService cs = new CustomerService();
		List<String> errors = new ArrayList<>();

		// Validation
		if (username == null || username.isBlank())
			errors.add("名前の入力は必須です");
		if (furikana == null || !cs.isValidKanaName(furikana))
			errors.add("フリガナは全角カタカナで入力してください。スペースは入力しないでください。");
		if (usermail == null || usermail.isBlank())
			errors.add("メールアドレスの入力は必須です");
		if (cs.emailExists(usermail)) 
			errors.add("入力されたメールアドレスは既に登録されています");
		if (usertel == null || usertel.isBlank())
			errors.add("電話番号の入力は必須です");
		if (!cs.isValidPassword(userpass))
			errors.add("パスワードは8文字以上で、少なくとも1つの数字を含めてください。");
		if (!cs.passwordsMatch(userpass, repassword))
			errors.add("パスワードと確認用パスワードが一致していません。");

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
		Customer temp = new Customer(username, furikana, usermail, usertel, userpass,userpoint);
		session.setAttribute("tempUser", temp);

		// Forward to confirmation page
		request.getRequestDispatcher("registerConfirm.jsp").forward(request, response);

	}

}
