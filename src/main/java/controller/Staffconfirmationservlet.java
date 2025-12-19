package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Staff;
import service.CustomerService;

/**
 * Servlet implementation class Staffconfirmationservlet
 */
@WebServlet("/Staffconfirmationservlet")
public class Staffconfirmationservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Staffconfirmationservlet() {
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
		request.setCharacterEncoding("UTF-8");

		request.setCharacterEncoding("UTF-8");

		String staffname = request.getParameter("staffname");
		String staffnamefurigana = request.getParameter("staffnamefurigana");
		String stafftype = request.getParameter("stafftype");
		String staffphone = request.getParameter("staffphone");
		String staffemail = request.getParameter("staffemail");
		String staffaddress = request.getParameter("staffaddress");
		String staffpassword = request.getParameter("staffpassword");

		CustomerService ss = new CustomerService();
		List<String> errors = new ArrayList<>();

		// Validation
		if (staffname == null || staffname.isBlank())
			errors.add("Name is required.");

		if (staffnamefurigana == null || !ss.isValidKanaName(staffnamefurigana))
			errors.add("Furigana must be full-width Katakana.");

		if (stafftype == null || stafftype.isBlank())
			errors.add("Staff Type is required.");

		if (staffphone == null || staffphone.isBlank())
			errors.add("Phone is required.");

		if (staffemail == null || staffemail.isBlank())
			errors.add("Email is required.");

		if (ss.mailexists(staffemail)) 
			errors.add("Email already exists");
		
		if (staffaddress == null || staffaddress.isBlank())
			errors.add("Address is required.");

		if (!ss.isValidPassword(staffpassword))
			errors.add("Password must be at least 8 characters and contain a number.");

		if (!errors.isEmpty()) {
			request.setAttribute("errors", errors);

			request.setAttribute("staffname", staffname);
			request.setAttribute("staffnamefurigana", staffnamefurigana);
			request.setAttribute("stafftype", stafftype);
			request.setAttribute("staffphone", staffphone);
			request.setAttribute("staffemail", staffemail);
			request.setAttribute("staffaddress", staffaddress);

			request.getRequestDispatcher("/Admin/staffregisteration.jsp").forward(request, response);
			return;
		}

		// Save to session
		HttpSession session = request.getSession();
		Staff tempStaff = new Staff(
				staffname,
				staffnamefurigana,
				stafftype,
				staffphone,
				staffemail,
				staffaddress,
				staffpassword);

		session.setAttribute("tempStaff", tempStaff);

		request.getRequestDispatcher("/Admin/staffRegisterConfirm.jsp").forward(request, response);

	}

}
