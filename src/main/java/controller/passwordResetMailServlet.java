package controller;

import java.io.IOException;
import java.util.UUID;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CustomerDao;
import dao.PasswordResetTokenDao;
import model.Customer;
import service.PasswordReset_MailSender;

/**
 * Servlet implementation class passwordResetMailServlet
 */
@WebServlet("/passwordResetMailServlet")
public class passwordResetMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public passwordResetMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("UTF-8");
	    String email = request.getParameter("usermail");
	    String phone = request.getParameter("phone");

	    CustomerDao customerDao = new CustomerDao();
	    Customer customer = customerDao.findByEmailAndPhone(email, phone);

	    if (customer != null) {
	        // トークン生成
	        String token = UUID.randomUUID().toString();

	        // トークン保存
	        PasswordResetTokenDao tokenDao = new PasswordResetTokenDao();
	        tokenDao.saveResetToken(customer.getUserId(), token);

	        // 再設定URL
	        String resetUrl = request.getScheme() + "://"
	                + request.getServerName() + ":"
	                + request.getServerPort()
	                + request.getContextPath()
	                + "/PasswordResetFormServlet?token=" + token;

	         //メール送信
	        try {
				PasswordReset_MailSender.send(
				    customer.getEmail(),
				    "パスワード再設定のご案内",
				    "以下のURLから30分以内に再設定してください。\n\n" + resetUrl
				);
			} catch (MessagingException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
	    }

	    // 成否に関わらず同じ画面へ
	    request.setAttribute("message",
	        "入力されたメールアドレスにパスワード再設定用URLを送信しました。");
	    request.getRequestDispatcher("passwordResetMailComplete.jsp")
	           .forward(request, response);
	}


	}


