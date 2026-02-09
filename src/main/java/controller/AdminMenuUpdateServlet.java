package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import service.MenuService;

/**
 * Servlet implementation class AdminMenuUpdateServlet
 */
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024,
		  maxFileSize = 5 * 1024 * 1024,
		  maxRequestSize = 10 * 1024 * 1024
		)

@WebServlet("/AdminMenuUpdateServlet")
public class AdminMenuUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMenuUpdateServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		int menuId = Integer.parseInt(request.getParameter("menuId"));
		String menuName = request.getParameter("menuName");
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");

		String imagePath = request.getParameter("currentImage"); // default

		Part imagePart = request.getPart("imageFile");

		if (imagePart != null && imagePart.getSize() > 0) {
		    String fileName = Paths.get(imagePart.getSubmittedFileName())
		                           .getFileName().toString();

		    String uploadPath = getServletContext().getRealPath("/menuimg");
		    File dir = new File(uploadPath);
		    if (!dir.exists()) dir.mkdirs();

		    imagePart.write(uploadPath + File.separator + fileName);

		    imagePath = "menuimg/" + fileName; // overwrite
		}


        MenuService service = new MenuService();
        service.updateMenu(menuId, menuName, category, price, description,imagePath);

        // 一覧画面へ戻る（編集モード解除）
        response.sendRedirect("AdminMenuEditServlet");
	}

}