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

@WebServlet("/admin/coupon/update")
@MultipartConfig
public class CouponUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			req.setCharacterEncoding("UTF-8");

			Coupon c = new Coupon();

			c.setCouponId(Integer.parseInt(req.getParameter("couponId")));
			c.setTitle(req.getParameter("title"));
			c.setDescription(req.getParameter("description"));
			c.setDiscountAmount(Integer.parseInt(req.getParameter("discountAmount")));
			c.setStartDate(LocalDate.parse(req.getParameter("startDate")));
			c.setEndDate(LocalDate.parse(req.getParameter("endDate")));
			c.setMinPoint(Integer.parseInt(req.getParameter("minPoint")));
			c.setReservationType(req.getParameter("reservationType"));

			// ===== IMAGE HANDLE =====
			Part filePart = req.getPart("image");
			String oldImage = req.getParameter("oldImage");

			if (filePart != null && filePart.getSize() > 0) {

				String fileName = System.currentTimeMillis() + "_" +
						Paths.get(filePart.getSubmittedFileName())
								.getFileName().toString();

				String uploadPath = getServletContext().getRealPath("/coupon");

				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists())
					uploadDir.mkdirs();

				filePart.write(uploadPath + File.separator + fileName);

				c.setImagePath("coupon/" + fileName);

			} else {
				// keep old image
				c.setImagePath(oldImage);
			}

			new CouponDao().update(c);

			resp.sendRedirect(req.getContextPath() + "/admin/coupon/list");

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
