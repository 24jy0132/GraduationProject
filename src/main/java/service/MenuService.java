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
}
