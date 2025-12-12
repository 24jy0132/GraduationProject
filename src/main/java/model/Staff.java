package model;

public class Staff {

    private int staffId;
    private String staffName;
    private String staffNameFurigana;
    private String staffType;
    private String staffPhone;
    private String staffEmail;
    private String staffAddress;
    private String staffPassword;

    public Staff() {}
    
    public Staff(String staffName, String staffNameFurigana, String staffType,
            String staffPhone, String staffEmail, String staffAddress, String staffPassword) {
   this.staffName = staffName;
   this.staffNameFurigana = staffNameFurigana;
   this.staffType = staffType;
   this.staffPhone = staffPhone;
   this.staffEmail = staffEmail;
   this.staffAddress = staffAddress;
   this.staffPassword = staffPassword;
}

    public Staff(int staffId, String staffName, String staffNameFurigana, String staffType,
                 String staffPhone, String staffEmail, String staffAddress, String staffPassword) {
        this.staffId = staffId;
        this.staffName = staffName;
        this.staffNameFurigana = staffNameFurigana;
        this.staffType = staffType;
        this.staffPhone = staffPhone;
        this.staffEmail = staffEmail;
        this.staffAddress = staffAddress;
        this.staffPassword = staffPassword;
    }

    // ===== Getters & Setters =====
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffNameFurigana() {
        return staffNameFurigana;
    }

    public void setStaffNameFurigana(String staffNameFurigana) {
        this.staffNameFurigana = staffNameFurigana;
    }

    public String getStaffType() {
        return staffType;
    }

    public void setStaffType(String staffType) {
        this.staffType = staffType;
    }

    public String getStaffPhone() {
        return staffPhone;
    }

    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }

    public String getStaffEmail() {
        return staffEmail;
    }

    public void setStaffEmail(String staffEmail) {
        this.staffEmail = staffEmail;
    }

    public String getStaffAddress() {
        return staffAddress;
    }

    public void setStaffAddress(String staffAddress) {
        this.staffAddress = staffAddress;
    }

    public String getStaffPassword() {
        return staffPassword;
    }

    public void setStaffPassword(String staffPassword) {
        this.staffPassword = staffPassword;
    }
}