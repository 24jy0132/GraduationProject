package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDao;
import model.Customer;
import service.CustomerService;

@WebServlet("/member/edit")
public class MemberEditServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		Customer customer = (Customer) session.getAttribute("customer");

		if (customer == null) {
			res.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		Customer customer = (Customer) session.getAttribute("customer");

		if (customer == null) {
			res.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");

		CustomerService service = new CustomerService();

		// =========================
		// VALIDATION
		// =========================
		if (name == null || name.isBlank()
				|| email == null || email.isBlank()) {

			req.setAttribute("errorMessage", "必須項目を入力してください。");
			req.getRequestDispatcher("/member_edit.jsp")
					.forward(req, res);
			return;
		}

		// =========================
		// EMAIL DUPLICATE CHECK
		// =========================
		if (service.mailExistsForOtherUser(email, customer.getUserId())) {
			req.setAttribute("errorMessage", "このメールアドレスは既に使用されています。");
			req.getRequestDispatcher("/member_edit.jsp")
					.forward(req, res);
			return;
		}

		try {
			// update values
			customer.setName(name);
			customer.setEmail(email);
			customer.setPhone(phone);

			CustomerDao dao = new CustomerDao();
			dao.update(customer);

			// refresh session
			Customer refreshed = dao.findById(customer.getUserId());
			session.setAttribute("customer", refreshed);

			// success toast
			req.setAttribute("successMessage", "会員情報を更新しました。");

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(
					"errorMessage",
					"更新に失敗しました。もう一度お試しください。");
		}

		// forward so toast is visible
		req.getRequestDispatcher("/member_edit.jsp")
				.forward(req, res);
	}
}
