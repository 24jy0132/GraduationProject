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

		// Existing fields
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");

		// New Password fields
		String newPassword = req.getParameter("newPassword");
		String rePassword = req.getParameter("rePassword");

		CustomerService service = new CustomerService();
		CustomerDao dao = new CustomerDao();

		// =========================
		// VALIDATION (Profile)
		// =========================
		// =========================
		// VALIDATION (Profile)
		// =========================
		if (name == null || name.isBlank() || email == null || email.isBlank()) {
			req.setAttribute("errorMessage", "必須項目を入力してください。");
			req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
			return;
		}

		// =========================
		// VALIDATION (Phone)
		// =========================
		if (phone == null || !phone.matches("^\\d{10,11}$")) {
			req.setAttribute("errorMessage", "電話番号は数字のみで10〜11桁で入力してください。");
			req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
			return;
		}

		if (service.mailExistsForOtherUser(email, customer.getUserId())) {
			req.setAttribute("errorMessage", "このメールアドレスは既に使用されています。");
			req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
			return;
		}

		// =========================
		// VALIDATION (Password)
		// =========================
		boolean isUpdatingPassword = (newPassword != null && !newPassword.isBlank());

		if (isUpdatingPassword) {
			if (!service.isValidPassword(newPassword)) {
				req.setAttribute("errorMessage", "パスワードは8文字以上で数字を含めてください。");
				req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
				return;
			}
			if (!service.passwordsMatch(newPassword, rePassword)) {
				req.setAttribute("errorMessage", "確認用パスワードが一致しません。");
				req.getRequestDispatcher("/member_edit.jsp").forward(req, res);
				return;
			}
		}

		try {
			// ✅ Only AFTER all validation passed
			customer.setName(name);
			customer.setEmail(email);
			customer.setPhone(phone);

			dao.update(customer);

			if (isUpdatingPassword) {
				dao.updatePassword(customer.getUserId(), newPassword);
			}

			Customer refreshed = dao.findById(customer.getUserId());
			session.setAttribute("customer", refreshed);

			req.setAttribute("successMessage", "情報を更新しました。");

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("errorMessage", "更新に失敗しました。");
		}
	}
}
