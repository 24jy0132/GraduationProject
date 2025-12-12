package model;

public class Menu {
	private int menuId;
	private String menuname;
	private String description;
	private double price;
	private String category;
	private String imagePath;

	public Menu() {

	}

	public Menu(int menuId, String menuname, String description, double price, String category, String imagePath) {
		super();
		this.menuId = menuId;
		this.menuname = menuname;
		this.description = description;
		this.price = price;
		this.category = category;
		this.imagePath = imagePath;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
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

}
