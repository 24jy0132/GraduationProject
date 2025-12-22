package model;

public class Customer {
	
	private int userId;
	private String name;
	private String nameKana;
	private String email;
	private String phone;
	private String password;
	private int point;
	public Customer() {
		
	}
	public Customer(String name,String nameKana,String email,String phone,String password,int point) {
		super();
		this.name = name;
		this.nameKana = nameKana;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.point=point;
		}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameKana() {
		return nameKana;
	}
	public void setNameKana(String nameKana) {
		this.nameKana = nameKana;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point=point;
	}
	
}
