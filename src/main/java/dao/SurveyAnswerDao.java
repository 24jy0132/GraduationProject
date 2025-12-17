package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SurveyAnswerDao {
    private Connection con = null;

    public SurveyAnswerDao() {
    	try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://10.64.144.5:3306/" + "24jy0234?characterEncoding=UTF-8",
					"24jy0234", "24jy0234");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
    }

    public void connectionClose() {
        try {
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Inserts 4 rows (taste/volume/price/comment)
    public void insertAnswers(int surveyId, int menuId, int userId,
                              String taste, String volume, String price, String comment) {

        String sql = "INSERT INTO survey_answer " +
                     "(surveyId, menuId, userId, questionId, answerText) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            insertOne(ps, surveyId, menuId, userId, 1, taste);   // TASTE
            insertOne(ps, surveyId, menuId, userId, 2, volume);  // VOLUME
            insertOne(ps, surveyId, menuId, userId, 3, price);   // PRICE
            insertOne(ps, surveyId, menuId, userId, 4, comment); // COMMENT

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void insertOne(PreparedStatement ps,
                           int surveyId, int menuId, int userId,
                           int questionId, String answerText) throws SQLException {

        ps.setInt(1, surveyId);
        ps.setInt(2, menuId);
        ps.setInt(3, userId);
        ps.setInt(4, questionId);
        ps.setString(5, answerText);
        ps.executeUpdate();
    }
}
