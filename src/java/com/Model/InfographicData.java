/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.util.List;

/**
 *
 * @author DELL
 */
public class InfographicData {
    
    private String title;
    private List<String> labels;
    private List<Integer> values;
    private List<String> colors;

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the labels
     */
    public List<String> getLabels() {
        return labels;
    }

    /**
     * @param labels the labels to set
     */
    public void setLabels(List<String> labels) {
        this.labels = labels;
    }

    /**
     * @return the values
     */
    public List<Integer> getValues() {
        return values;
    }

    /**
     * @param values the values to set
     */
    public void setValues(List<Integer> values) {
        this.values = values;
    }

    /**
     * @return the colors
     */
    public List<String> getColors() {
        return colors;
    }

    /**
     * @param colors the colors to set
     */
    public void setColors(List<String> colors) {
        this.colors = colors;
    }
    
}
