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

/**
 * Servlet implementation class Adminloginpageservlet
 */
@WebServlet("/Adminloginpageservlet")
public class Adminloginpageservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Adminloginpageservlet() {
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
		response.setContentType("text/html");
		String inputemail = request.getParameter("inputemail");
		String inputpassword = request.getParameter("inputpassword");

		StaffDao sd = new StaffDao();
		Staff staff = sd.findStaffByEmailAndPassword(inputemail, inputpassword);

		HttpSession session = request.getSession();
		if (staff != null && "admin".equalsIgnoreCase(staff.getStaffType())) {
			session.setAttribute("admin", staff);
			request.getRequestDispatcher("/Admin/adminhome.jsp").forward(request, response);
		} else {
			request.setAttribute("error", "Invalid login");
			request.getRequestDispatcher("/Admin/adminlogin.jsp").forward(request, response);
		}
	}

}
