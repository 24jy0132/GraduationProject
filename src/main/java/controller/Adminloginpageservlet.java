package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StaffDao;
import model.Staff;

@WebServlet("/Adminloginpageservlet")
public class Adminloginpageservlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String inputemail = request.getParameter("inputemail");
		String inputpassword = request.getParameter("inputpassword");

		// ===== 1️⃣ EMPTY CHECK =====
		if (inputemail == null || inputemail.isBlank()
				|| inputpassword == null || inputpassword.isBlank()) {

			request.setAttribute("errorMessage", "入力項目を確認してください");
			request.getRequestDispatcher("/Admin/adminlogin.jsp")
					.forward(request, response);
			return;
		}

		// ===== 2️⃣ LOGIN CHECK =====
		StaffDao sd = new StaffDao();
		Staff staff = sd.findStaffByEmailAndPassword(inputemail, inputpassword);

		if (staff != null && "staff".equalsIgnoreCase(staff.getStaffType())) {

			HttpSession session = request.getSession();
			session.setAttribute("admin", staff);

			response.sendRedirect(
					request.getContextPath() + "/Admin/adminhome.jsp");

		} else {

			request.setAttribute("errorMessage", "入力項目を確認してください");
			request.getRequestDispatcher("/Admin/adminlogin.jsp")
					.forward(request, response);
		}
	}
}
