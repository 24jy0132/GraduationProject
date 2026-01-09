package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.Test_MailSender;

/**
 * Servlet implementation class Test_SendMailServlet
 */
@WebServlet("/Test_SendMailServlet")
public class Test_SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Test_SendMailServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			Test_MailSender.send();
			response.getWriter().println("送信成功");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("送信失敗: " + e.getMessage());
		}

	}
}
