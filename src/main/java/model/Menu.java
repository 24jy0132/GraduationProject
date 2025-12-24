package model;

public class Menu {
    private int menuId;          // メニューコード
    private String menuName;         // メニュー名
    private String description;  // メニュー説明
    private int price;           // 値段
    private String category;        // メニュージャンル
    private String imagePath;    // メニュー画像
    private boolean isSurveyTarget;
    private int surveyId;    
    private int durationMinutes ;
    public int getDurationMinutes() {
		return durationMinutes;
	}
	public void setDurationMinutes(int durationMinutes) {
		this.durationMinutes = durationMinutes;
	}
	// アンケートコード(FK)
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public boolean isSurveyTarget() {
		return isSurveyTarget;
	}
	public void setSurveyTarget(boolean isSurveyTarget) {
		this.isSurveyTarget = isSurveyTarget;
	}
	public int getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}

    
}
