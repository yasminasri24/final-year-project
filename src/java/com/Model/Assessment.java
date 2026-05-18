/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.util.Date;

/**
 *
 * @author DELL
 */
public class Assessment {
    private int assessmentID;
    private int studentID;
    private String studentname;
    private Date date;
    private int depressionScore;
    private int anxietyScore;
    private int stressScore;
    private String depressionResult;
    private String anxietyResult;
    private String stressResult;
    private String recommendation;
    private String status;
    
    public Assessment(){
        
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
     * @return the depressionScore
     */
    public int getDepressionScore() {
        return depressionScore;
    }

    /**
     * @param depressionScore the depressionScore to set
     */
    public void setDepressionScore(int depressionScore) {
        this.depressionScore = depressionScore;
    }

    /**
     * @return the anxietyScore
     */
    public int getAnxietyScore() {
        return anxietyScore;
    }

    /**
     * @param anxietyScore the anxietyScore to set
     */
    public void setAnxietyScore(int anxietyScore) {
        this.anxietyScore = anxietyScore;
    }

    /**
     * @return the stressScore
     */
    public int getStressScore() {
        return stressScore;
    }

    /**
     * @param stressScore the stressScore to set
     */
    public void setStressScore(int stressScore) {
        this.stressScore = stressScore;
    }

    /**
     * @return the depressionResult
     */
    public String getDepressionResult() {
        return depressionResult;
    }

    /**
     * @param depressionResult the depressionResult to set
     */
    public void setDepressionResult(String depressionResult) {
        this.depressionResult = depressionResult;
    }

    /**
     * @return the anxietyResult
     */
    public String getAnxietyResult() {
        return anxietyResult;
    }

    /**
     * @param anxietyResult the anxietyResult to set
     */
    public void setAnxietyResult(String anxietyResult) {
        this.anxietyResult = anxietyResult;
    }

    /**
     * @return the stressResult
     */
    public String getStressResult() {
        return stressResult;
    }

    /**
     * @param stressResult the stressResult to set
     */
    public void setStressResult(String stressResult) {
        this.stressResult = stressResult;
    }

    /**
     * @return the recommendation
     */
    public String getRecommendation() {
        return recommendation;
    }

    /**
     * @param recommendation the recommendation to set
     */
    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
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
    
    
    
    
}
