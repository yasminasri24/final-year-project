/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author DELL
 */
public class Question {
    
    private int questionID;
    private String questionText;
    private int weight;
    private String category;
    
    public Question() {
        
    }
    
    public Question(int questionID, String questionText, int weight, String category) {
        this.questionID = questionID;
        this.questionText = questionText;
        this.weight = weight;
        this.category = category;
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
     * @return the questionText
     */
    public String getQuestionText() {
        return questionText;
    }

    /**
     * @param questionText the questionText to set
     */
    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    /**
     * @return the weight
     */
    public int getWeight() {
        return weight;
    }

    /**
     * @param weight the weight to set
     */
    public void setWeight(int weight) {
        this.weight = weight;
    }

    /**
     * @return the responseValue
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param responseValue the responseValue to set
     */
    public void setCategory(String category) {
        this.category = category;
    }
    
    
}
