/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author DELL
 */
public class Appointment {
    
    private int appointmentID;
    private int studentID;
    private int counselorID;
    private Date date;
    private Time time;
    private String category;
    private String typeCounseling;
    private String groupMembers;
    private String status;
    private String eventID;
    private String notes;
    private String studentEmail;
    private String counselorEmail;
    private Counselor counselor;
    private Student student;
    private String studentname;
    private boolean feedbackSubmitted;
    
    public Appointment() {
        
    }

    /**
     * @return the appointmentID
     */
    public int getAppointmentID() {
        return appointmentID;
    }

    /**
     * @param appointmentID the appointmentID to set
     */
    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    /**
     * @return the studentID
     */
    public int getStudentID() {
        return studentID;
    }

    /**
     * @param studentID the studentID to set
     */
    public void setStudentID(int studentID) {
        this.studentID = studentID;
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
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }

    /**
     * @return the time
     */
    public Time getTime() {
        return time;
    }

    /**
     * @param time the time to set
     */
    public void setTime(Time time) {
        this.time = time;
    }

    /**
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * @return the typeCounseling
     */
    public String getTypeCounseling() {
        return typeCounseling;
    }

    /**
     * @param typeCounseling the typeCounseling to set
     */
    public void setTypeCounseling(String typeCounseling) {
        this.typeCounseling = typeCounseling;
    }

    /**
     * @return the groupMembers
     */
    public String getGroupMembers() {
        return groupMembers;
    }

    /**
     * @param groupMembers the groupMembers to set
     */
    public void setGroupMembers(String groupMembers) {
        this.groupMembers = groupMembers;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the eventID
     */
    public String getEventID() {
        return eventID;
    }

    /**
     * @param eventID the eventID to set
     */
    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    /**
     * @return the studentEmail
     */
    public String getStudentEmail() {
        return studentEmail;
    }

    /**
     * @param studentEmail the studentEmail to set
     */
    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    /**
     * @return the counselorEmail
     */
    public String getCounselorEmail() {
        return counselorEmail;
    }

    /**
     * @param counselorEmail the counselorEmail to set
     */
    public void setCounselorEmail(String counselorEmail) {
        this.counselorEmail = counselorEmail;
    }

    /**
     * @return the counselor
     */
    public Counselor getCounselor() {
        return counselor;
    }

    /**
     * @param counselor the counselor to set
     */
    public void setCounselor(Counselor counselor) {
        this.counselor = counselor;
    }

    /**
     * @return the student
     */
    public Student getStudent() {
        return student;
    }

    /**
     * @param student the student to set
     */
    public void setStudent(Student student) {
        this.student = student;
    }

    /**
     * @return the studentname
     */
    public String getStudentname() {
        return studentname;
    }

    /**
     * @param studentname the studentname to set
     */
    public void setStudentname(String studentname) {
        this.studentname = studentname;
    }

    /**
     * @return the feedbackSubmitted
     */
    public boolean isFeedbackSubmitted() {
        return feedbackSubmitted;
    }

    /**
     * @param feedbackSubmitted the feedbackSubmitted to set
     */
    public void setFeedbackSubmitted(boolean feedbackSubmitted) {
        this.feedbackSubmitted = feedbackSubmitted;
    }

    /**
     * @return the notes
     */
    public String getNotes() {
        return notes;
    }

    /**
     * @param notes the notes to set
     */
    public void setNotes(String notes) {
        this.notes = notes;
    }
 
}
