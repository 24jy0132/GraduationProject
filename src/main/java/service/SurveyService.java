package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.SurveyAnswerDao;
import model.Menu;

public class SurveyService {

	 public void submitSurvey(int surveyId, int menuId, int userId,
             String taste, String volume, String price, String comment) {
			SurveyAnswerDao dao = new SurveyAnswerDao();

		try {
		// 1) save answers
		dao.insertAnswers(surveyId, menuId, userId, taste, volume, price, comment);
		
		// 2) add points
		dao.addPoints(userId);
		
		} finally {
		dao.connectionClose();
		}
	 }
	 
	 public Map<Integer, Map<String,Integer>> getTasteSummaryForMenus(List<Menu> surveyMenus){
		 
		Map<Integer, Map<String, Integer>> result = new HashMap<>();
		SurveyAnswerDao dao = new SurveyAnswerDao();
		
		for(Menu sm:surveyMenus) {
			Map<String,Integer> tasteMap = dao.getTasteSummaryForMenus(sm.getMenuId(),1);
			result.put(sm.getMenuId(), tasteMap);
		}
		
		dao.connectionClose();

		 return result;
	 }
}
