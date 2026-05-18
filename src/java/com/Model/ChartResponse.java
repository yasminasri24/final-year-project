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
public class ChartResponse {
    
    private String chartType;
    private String title;
    private List<String> labels;
    private List<Integer> values;
    private List<String> colors;
    
    public ChartResponse(InfographicData data, String chartType) {
        this.chartType = chartType;
        this.title = data.getTitle();
        this.labels = data.getLabels();
        this.values = data.getValues();
        this.colors = data.getColors();
    }

    /**
     * @return the chartType
     */
    public String getChartType() {
        return chartType;
    }

    /**
     * @param chartType the chartType to set
     */
    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

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
