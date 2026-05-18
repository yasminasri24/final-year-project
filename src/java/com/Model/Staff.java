/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author DELL
 */
public class Staff {
    
    private int userID;
    private String username;
    private String password;
    private String email;
    private int staffID;
    private String staffname;
    private String departmentS;
    
    public Staff() {   
    }

    /**
     * @return the userID
     */
    public int getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the staffName
     */
    public String getStaffname() {
        return staffname;
    }

    /**
     * @param staffname the staffName to set
     */
    public void setStaffname(String staffname) {
        this.staffname = staffname;
    }

    /**
     * @return the department
     */
    public String getDepartmentS() {
        return departmentS;
    }

    /**
     * @param departmentS the department to set
     */
    public void setDepartmentS(String departmentS) {
        this.departmentS = departmentS;
    }

    /**
     * @return the staffID
     */
    public int getStaffID() {
        return staffID;
    }

    /**
     * @param staffID the staffID to set
     */
    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
    
}
