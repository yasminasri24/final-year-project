/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author DELL
 */
public class Counselor {

    private int userID;
    private String username;
    private String password;
    private String email;
    private int counselorID;
    private String counselorname;
    private String specialization;
    private String phoneC;
    
    public Counselor() {
        
    }
   
    /**
     * @return the counselorID
     */
    public int getCounselorID() {
        return counselorID;
    }

    /**
     * @param counselorID the counselorID to set
     */
    public void setCounselorID(int counselorID) {
        this.counselorID = counselorID;
    }
    
    /**
     * @return the counselorname
     */
    public String getCounselorname() {
        return counselorname;
    }

    /**
     * @param counselorname the counselorname to set
     */
    public void setCounselorname(String counselorname) {
        this.counselorname = counselorname;
    }

    /**
     * @return the specialization
     */
    public String getSpecialization() {
        return specialization;
    }

    /**
     * @param specialization the specialization to set
     */
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    /**
     * @return the departmentC
     */
    public String getPhoneC() {
        return phoneC;
    }

    /**
     * @param departmentC the departmentC to set
     */
    public void setPhoneC(String phoneC) {
        this.phoneC = phoneC;
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
  
}
