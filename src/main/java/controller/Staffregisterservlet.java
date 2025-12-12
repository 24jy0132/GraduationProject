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
 * Servlet implementation class Staffregisterservlet
 */
@WebServlet("/Staffregisterservlet")
public class Staffregisterservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Staffregisterservlet() {
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
		doGet(request, response);
		response.setContentType("text/html");

		// Get staff form parameters
		String staffName = request.getParameter("staffname");
		String staffFurigana = request.getParameter("staffnamefurigana");
		String staffType = request.getParameter("stafftype");
		String staffPhone = request.getParameter("staffphone");
		String staffEmail = request.getParameter("staffemail");
		String staffAddress = request.getParameter("staffaddress");
		String staffPassword = request.getParameter("staffpassword");
		String staffRePassword = request.getParameter("staffrepassword");

		CustomerService ss = new CustomerService();
		List<String> errors = new ArrayList<>();

		if (staffName == null || staffName.trim().isEmpty()) {
			errors.add("従業員名は必須です。");
		}

		if (!ss.isValidKanaName(staffFurigana)) {
			errors.add("従業員名フリガナは全角カタカナで入力してください。");
		}

		if (staffType == null || staffType.equals("従業員種類")) {
			errors.add("従業員種類を選択してください。");
		}

		if (staffPhone == null || staffPhone.trim().isEmpty()) {
			errors.add("電話番号は必須です。");
		}

		if (staffEmail == null || staffEmail.trim().isEmpty()) {
			errors.add("メールは必須です。");
		}

		if (!ss.isValidPassword(staffPassword)) {
			errors.add("パスワードは8文字以上かつ数字を含めてください。");
		}

		if (!ss.passwordsMatch(staffPassword, staffRePassword)) {
			errors.add("パスワードとパスワード確認が一致しません。");
		}

		// 8. Optional: Address check
		if (staffAddress == null || staffAddress.trim().isEmpty()) {
			errors.add("住所は必須です。");
		}

		if (!errors.isEmpty()) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("staffRegister.jsp").forward(request, response);
			return;
		}

	}

}
