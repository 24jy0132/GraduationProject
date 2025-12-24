package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.TableDao;

/**
 * Servlet implementation class Bill_request_Servlet
 */
@WebServlet("/Bill_request_Servlet")
public class Bill_request_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bill_request_Servlet() {
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
		// ① JSPから送られてきた卓番号を取得
        String table_id = request.getParameter("table_id");

        // パラメータチェック
        if (table_id == null || table_id.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        // ② DAOを使って会計依頼処理
        TableDao tableDao = new TableDao();
        boolean success = tableDao.requestCheckout(table_id);

        // ③ 結果に応じて画面遷移
        if (success) {
            request.setAttribute("table_id", table_id);
            request.getRequestDispatcher("/bill_request/bill_request_complete.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error", "会計依頼に失敗しました。");
            request.getRequestDispatcher("error.jsp")
                   .forward(request, response);
        }
    }

}
