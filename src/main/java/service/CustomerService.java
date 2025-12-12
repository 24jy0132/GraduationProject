package service;

import dao.CustomerDao;
import model.Customer;

public class CustomerService {
	CustomerDao cd = new CustomerDao();

	public boolean accountExists(String email, String password) {
		Customer cus = cd.findByEmailAndPassword(email, password);
		boolean pass = false;
		if (cus != null) {
			pass = true;
		}
		return pass; // user exists
	}

	public boolean isValidKanaName(String name) {
		if (name == null)
			return false;
		return name.matches("^[\\u30A0-\\u30FF]+$");
	}

	public boolean isValidPassword(String password) {
		if (password == null)
			return false;
		return password.matches("^(?=.*[0-9]).{8,}$");
	}

	public boolean passwordsMatch(String password, String repassword) {
		if (password == null || repassword == null)
			return false;
		return password.equals(repassword);
	}

	public boolean mailexists(String mail) {
		Customer cuss = cd.findByEmail(mail);
		boolean pass = false;
		if (cuss != null) {
			pass = true;
		}
		return pass;
	}
}
