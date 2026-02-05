package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import dao.CouponDao;
import model.Coupon;

@WebServlet("/admin/coupon/save")
@MultipartConfig
public class AdminCouponSaveServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		Coupon c = new Coupon();
		c.setTitle(request.getParameter("title"));
		c.setDescription(request.getParameter("description"));
		c.setDiscountAmount(Integer.parseInt(request.getParameter("discountAmount")));
		c.setMinPoint(Integer.parseInt(request.getParameter("minPoint")));
		c.setReservationType(request.getParameter("reservationType"));
		c.setStartDate(LocalDate.parse(request.getParameter("startDate")));
		c.setEndDate(LocalDate.parse(request.getParameter("endDate")));

		// ===== IMAGE UPLOAD =====
		Part filePart = request.getPart("image");

		if (filePart != null && filePart.getSize() > 0) {

			String fileName = System.currentTimeMillis() + "_" +
					Paths.get(filePart.getSubmittedFileName())
							.getFileName().toString();

			// WebContent/coupons
			String uploadPath = getServletContext().getRealPath("/coupons");

			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists())
				uploadDir.mkdirs();

			filePart.write(uploadPath + File.separator + fileName);

			// Save relative path
			c.setImagePath("coupons/" + fileName);
		}

		try {
			CouponDao dao = new CouponDao();
			dao.insert(c);
		} catch (Exception e) {
			throw new ServletException(e);
		}

		response.sendRedirect(
				request.getContextPath() + "/admin/coupon/list");
	}
}
