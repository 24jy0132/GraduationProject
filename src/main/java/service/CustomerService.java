package service;

import dao.CustomerDao;
import dao.StaffDao;
import model.Customer;
import model.Staff;

public class CustomerService {
	CustomerDao cd = new CustomerDao();
	StaffDao sd = new StaffDao();

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

	public boolean emailExists(String email) {

		if (email == null || email.isBlank()) {
			return false;
		}

		Staff staff = sd.findByEmail(email);
		if (staff != null) {
			return true;
		}

		return false;
	}

	public boolean mailExistsForOtherUser(String email, int currentUserId) {

		if (email == null || email.isBlank()) {
			return false;
		}

		// ❌ Staff always blocks customer email
		Staff staff = sd.findByEmail(email);
		if (staff != null) {
			return true;
		}

		// Customer check
		Customer found = cd.findByEmail(email);
		if (found == null) {
			return false;
		}

		// Same user → OK
		return found.getUserId() != currentUserId;
	}

}
