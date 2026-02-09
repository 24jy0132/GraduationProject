package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.MenuService;

@WebServlet("/AdminMenuNewToggleServlet")
public class AdminMenuNewToggleServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    int menuId = Integer.parseInt(request.getParameter("menuId"));
    int isNew = Integer.parseInt(request.getParameter("isNew"));

    MenuService service = new MenuService();
    service.updateIsNew(menuId, isNew);

    response.sendRedirect("AdminMenuEditServlet");
  }
}
