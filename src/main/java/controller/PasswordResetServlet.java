package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CustomerDao;
import dao.PasswordResetTokenDao;
import service.CustomerService;

/**
 * Servlet implementation class PasswordResetServlet
 */
@WebServlet("/PasswordResetServlet")
public class PasswordResetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PasswordResetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String token = request.getParameter("token");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");

		CustomerService service = new CustomerService();

		// =========================
		// BASIC INPUT CHECK
		// =========================
		if (token == null || token.isEmpty()) {
			request.setAttribute("error", "無効なリクエストです。");
			request.getRequestDispatcher("passwordResetError.jsp")
					.forward(request, response);
			return;
		}

		// =========================
		// PASSWORD FORMAT CHECK
		// =========================
		if (!service.isValidPassword(password)) {
			request.setAttribute(
					"error",
					"パスワードは8文字以上で、数字を1文字以上含めてください。");
			request.setAttribute("token", token);
			request.getRequestDispatcher("passwordResetForm.jsp")
					.forward(request, response);
			return;
		}

		// =========================
		// PASSWORD MATCH CHECK
		// =========================
		if (!service.passwordsMatch(password, passwordConfirm)) {
			request.setAttribute(
					"error",
					"パスワードと確認用パスワードが一致しません。");
			request.setAttribute("token", token);
			request.getRequestDispatcher("passwordResetForm.jsp")
					.forward(request, response);
			return;
		}

		PasswordResetTokenDao tokenDao = new PasswordResetTokenDao();
		CustomerDao customerDao = new CustomerDao();

		// =========================
		// TOKEN VALIDATION
		// =========================
		Integer userId = tokenDao.findValidUserIdByToken(token);

		if (userId == null) {
			request.setAttribute(
					"error",
					"URLの有効期限が切れているか、無効です。");
			request.getRequestDispatcher("passwordResetError.jsp")
					.forward(request, response);
			return;
		}

		// =========================
		// UPDATE PASSWORD
		// =========================
		customerDao.updatePassword(userId, password);

		// =========================
		// DELETE TOKEN (SECURITY)
		// =========================
		tokenDao.deleteByToken(token);

		// =========================
		// COMPLETE
		// =========================
		request.getRequestDispatcher("passwordResetComplete.jsp")
				.forward(request, response);
	}

}
