package service;
import java.util.List;

import dao.MenuDao;
import model.Menu;
public class MenuService {
	public List<Menu> getAllMenus() {
		MenuDao dao = new MenuDao();
		List<Menu> list = dao.findAll();
		dao.connectionClose();
		return list;
	}
	public List<Menu> getSurveyMenus() {
		MenuDao dao = new MenuDao();
		List<Menu> list = dao.findSurveyMenu();
		dao.connectionClose();
		return list;
	}
	
	public List<Menu> getNewMenus() {
		MenuDao dao = new MenuDao();
		List<Menu> list = dao.findNewMenu();
		dao.connectionClose();
		return list;
	}
	
	public Menu getMenuById(int menuId) {
		MenuDao dao= new MenuDao();
		Menu menu = dao.findById(menuId);
		dao.connectionClose();
		return menu;
	}
	public List<Menu> getMainMenus(){
		MenuDao dao = new MenuDao();
		List<Menu>list = dao.findMainMenu();
		dao.connectionClose();
		return list;
	}
	public List<Menu> getAlaCarteMenus(){
		MenuDao dao = new MenuDao();
		List<Menu>list = dao.findAlaCarteMenu();
		dao.connectionClose();
		return list;
	}
	public List<Menu> getSaladSoup(){
		MenuDao dao = new MenuDao();
		List<Menu>list = dao.findSaladSoup();
		dao.connectionClose();
		return list;
	}
	public List<Menu> getDrinks(){
		MenuDao dao = new MenuDao();
		List<Menu>list = dao.findDrinks();
		dao.connectionClose();
		return list;
	}
	public List<Menu> getCourse(){
		MenuDao dao = new MenuDao();
		List<Menu>list = dao.findCourse();
		dao.connectionClose();
		return list;
	}
	
	public void insertNewMenu(String menuName,String description,int price,String category,String imagePath,int isSurveyTarget,int surveyId,int isNew) {
		MenuDao dao = new MenuDao();
		dao.insertNewMenu(menuName,description,price,category,imagePath,isSurveyTarget,surveyId,isNew);
		dao.connectionClose();
		
	}
	
	public void deleteMenu(int menuId) {
		MenuDao dao= new MenuDao();
		dao.deleteMenu(menuId);
		dao.connectionClose();
	}
	
	public List<Menu> getNotSurveyMenus(){
		MenuDao dao= new MenuDao();
		List<Menu>list = dao.findNotSurveyMenus();
		dao.connectionClose();
		
		return list;
	}
	
	public void makeSurveyTarget(int menuId) {
		MenuDao dao = new MenuDao();
		dao.makeSurveyTarget(menuId);
		dao.connectionClose();

	}
	public void updateMenu(int menuId, String menuName, String category, int price, String description,String imagePath) {
	    MenuDao dao = new MenuDao();
	    dao.updateMenu(menuId, menuName, category, price, description, imagePath);
	    dao.connectionClose();
	}

	public void updateIsNew(int menuId, int isNew) {
	    MenuDao dao = new MenuDao();

	    dao.updateIsNew(menuId, isNew);
	}

	public void removeSurveyTarget(int menuId) {
	    MenuDao dao = new MenuDao();
	    dao.removeSurveyTarget(menuId);
	    dao.connectionClose();
	}

}


