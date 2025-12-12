package model;

import java.io.Serializable;

public class ReservationBean implements Serializable {
    private String date;        // 予約日
    private String time;        // 予約時間
    private int peopleCount;    // 大人人数
    private int childCount;     // 子供人数
    private String tableId;     // 選択されたテーブルID
    private String type;        // "SEAT" (席のみ) or "COURSE" (コース)
    private String courseId;    // コースID (コース予約の場合)
    
    // 予約者情報
    private String customerName;
    private String customerKana;
    private String phoneNumber;
    private String email;

    // Getters and Setters (省略せずに作成してください)
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    public int getPeopleCount() { return peopleCount; }
    public void setPeopleCount(int peopleCount) { this.peopleCount = peopleCount; }
    public int getChildCount() { return childCount; }
    public void setChildCount(int childCount) { this.childCount = childCount; }
    public String getTableId() { return tableId; }
    public void setTableId(String tableId) { this.tableId = tableId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getCustomerKana() { return customerKana; }
    public void setCustomerKana(String customerKana) { this.customerKana = customerKana; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
