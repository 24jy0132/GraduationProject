package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
/**
 * Servlet implementation class AdminMenuServlet
 */
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import model.Menu;
import service.MenuService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
@WebServlet("/AdminMenuEditServlet")
public class AdminMenuEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMenuEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		MenuService menuService = new MenuService();
		List<Menu> allMenus = menuService.getAllMenus();
		request.setAttribute("allMenus", allMenus);
		
		String editIdStr = request.getParameter("editId");
		
		if (editIdStr != null && !editIdStr.isEmpty()) {
			int editId = Integer.parseInt(editIdStr);
	        request.setAttribute("editId", editId);
	    }
		
		RequestDispatcher rd = request.getRequestDispatcher("/staffMenuEdit.jsp");

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		request.setCharacterEncoding("UTF-8");

		String menuName = request.getParameter("menuName");
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");		
		
		int isSurveyTarget = Integer.parseInt(request.getParameter("isSurveyTarget"));
		int surveyId = 1;
		int isNew = 1;
		
		// 画像アップロード
		Part part = request.getPart("imagePath");
		String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
		
		// 保存先（webapp の /menuimg）
        String uploadPath = getServletContext().getRealPath("/menuimg");
        if (uploadPath == null) {
            // fallback to temp folder if real path is not available
            uploadPath = System.getProperty("java.io.tmpdir") + File.separator + "menuimg";
        }
     // ★ DEBUG: check real upload path
        System.out.println("uploadPath=" + uploadPath);
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        // ★同名があると上書きされる（仕様としてOKならそのまま）
        part.write(uploadPath + File.separator + original);

        // DBへ保存するパス（URLとして使う）
        String imagePath = "menuimg/" + original;
		
		
		
		MenuService menuService = new MenuService();
		menuService.insertNewMenu(menuName,description,price,category,imagePath,isSurveyTarget,surveyId,isNew);

		request.setAttribute("message","新規メニューを追加しました");
		doGet(request,response);

		
		
	}

}
