package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CustomerDao;
import dao.PasswordResetTokenDao;
import model.Customer;

/**
 * Servlet implementation class PasswordResetFormServlet
 */
//ユーザがURLを開いた際にtokenが有効かを検証するためのサーブレット
@WebServlet("/PasswordResetFormServlet")
public class PasswordResetFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PasswordResetFormServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String token = request.getParameter("token");

	    if (token == null || token.isEmpty()) {
	        request.setAttribute("error", "無効なURLです。");
	        request.getRequestDispatcher("passwordResetError.jsp")
	               .forward(request, response);
	        return;
	    }

	    PasswordResetTokenDao tokenDao = new PasswordResetTokenDao();
	    Integer userId = tokenDao.findValidUserIdByToken(token);

	    if (userId == null) {
	        request.setAttribute("error", "URLの有効期限が切れているか、無効です。");
	        request.getRequestDispatcher("passwordResetError.jsp")
	               .forward(request, response);
	        return;
	    }

	    // Customerの取得（このServletでは未使用でもOK）
	    CustomerDao customerDao = new CustomerDao();
	    Customer customer = customerDao.findById(userId);

	    if (customer == null) {
	        request.setAttribute("error", "ユーザーが存在しません。");
	        request.getRequestDispatcher("passwordResetError.jsp")
	               .forward(request, response);
	        return;
	    }

	    // tokenをhiddenで次に渡す
	    request.setAttribute("token", token);
	    request.getRequestDispatcher("passwordResetForm.jsp")
	           .forward(request, response);
	}


}
