package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Customer;
import service.SurveyService;

@WebServlet("/SurveyDoneServlet")
public class SurveyDoneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // required
        int menuId = Integer.parseInt(request.getParameter("menuId"));

        // answers
        String taste = request.getParameter("taste");
        String volume = request.getParameter("volume"); // name="volume"
        String price = request.getParameter("price");
        String comment = request.getParameter("comment"); // can be null

        int surveyId = 1;
        
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("customer"); // ★ test user (later: from session after login)
        int userId = customer.getUserId();
        
        SurveyService service= new SurveyService();
        service.submitSurvey(surveyId, menuId, userId, taste, volume, price, comment);
        
        response.sendRedirect("SurveyDone.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // direct access -> go back to menu list
        response.sendRedirect("MenuListServlet");
    }
}