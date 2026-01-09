package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CustomerDao;
import dao.PasswordResetTokenDao;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");

        // 入力チェック
        if (token == null || token.isEmpty()
                || password == null || passwordConfirm == null
                || !password.equals(passwordConfirm)) {

            request.setAttribute("error", "入力内容が正しくありません。");
            request.getRequestDispatcher("passwordResetForm.jsp")
                   .forward(request, response);
            return;
        }

        PasswordResetTokenDao tokenDao = new PasswordResetTokenDao();
        CustomerDao customerDao = new CustomerDao();

        // token検証
        Integer userId = tokenDao.findValidUserIdByToken(token);
        if (userId == null) {
            request.setAttribute("error", "URLの有効期限が切れているか、無効です。");
            request.getRequestDispatcher("passwordResetError.jsp")
                   .forward(request, response);
            return;
        }

        // パスワード更新
        customerDao.updatePassword(userId, password);

        // token削除（再利用防止）
        tokenDao.deleteByToken(token);

        // 完了画面へ
        request.getRequestDispatcher("passwordResetComplete.jsp")
               .forward(request, response);
    }

}
