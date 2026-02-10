package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StaffDao;
import model.Staff;

/**
 * Servlet implementation class Staffinsertionservlet
 */
@WebServlet("/Staffinsertionservlet")
public class Staffinsertionservlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Staff temp = (Staff) session.getAttribute("tempStaff");

		if (temp == null) {
			response.sendRedirect(request.getContextPath() + "/Admin/staffregisteration.jsp");
			return;
		}

		StaffDao sd = new StaffDao();

		try {
			int result = sd.insert(temp);

			if (result == 1) {
				session.removeAttribute("tempStaff");
				session.setAttribute("message", "従業員登録が完了しました。");
				request.getRequestDispatcher("/Admin/staffregisterComplete.jsp")
						.forward(request, response);
			} else {
				request.setAttribute("errors",
						List.of("データベースエラーが発生しました。"));
				request.getRequestDispatcher("/Admin/staffregisteration.jsp")
						.forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errors",
					List.of("同じメールアドレスが既に登録されています。"));
			request.getRequestDispatcher("/Admin/staffregisteration.jsp")
					.forward(request, response);
		}
	}
}
