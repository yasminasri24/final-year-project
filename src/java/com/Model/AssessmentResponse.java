/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author DELL
 */
public class AssessmentResponse {
    private int responseID;
    private int studentID;
    private int assessmentID;
    private int questionID;   
    private int response;

    public AssessmentResponse() {}

    public AssessmentResponse(int responseID, int studentID, int assessmentID, int questionID, int response) {
        this.responseID = responseID;
        this.studentID = studentID;
        this.assessmentID = assessmentID;
        this.questionID = questionID;   
        this.response = response;
    }

    /**
     * @return the responseID
     */
    public int getResponseID() {
        return responseID;
    }

    /**
     * @param responseID the responseID to set
     */
    public void setResponseID(int responseID) {
        this.responseID = responseID;
    }

    /**
     * @return the assessmentID
     */
    public int getAssessmentID() {
        return assessmentID;
    }

    /**
     * @param assessmentID the assessmentID to set
     */
    public void setAssessmentID(int assessmentID) {
        this.assessmentID = assessmentID;
    }

    /**
     * @return the questionID
     */
    public int getQuestionID() {
        return questionID;
    }

    /**
     * @param questionID the questionID to set
     */
    public void setQuestionID(int questionID) {
        this.questionID = questionID;
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
     * @return the response
     */
    public int getResponse() {
        return response;
    }

    /**
     * @param response the response to set
     */
    public void setResponse(int response) {
        this.response = response;
    }
    
    
}


