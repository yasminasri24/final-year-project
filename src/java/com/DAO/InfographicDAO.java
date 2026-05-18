/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.InfographicData;
import com.Util.DBConnection;
import java.sql.*;
import java.util.*;

/**
 *
 * @author DELL
 */
public class InfographicDAO {

    public InfographicData getDataForType(String dataType) {
        InfographicData data = new InfographicData();

        try (Connection conn = DBConnection.getConnection()) {
            List<String> labels = new ArrayList<>();
            List<Integer> values = new ArrayList<>();
            List<String> colors = new ArrayList<>();
            String sql = "";
            String title = "";

            switch (dataType) {
                case "appointments":
                    sql = "SELECT MONTHNAME(date) AS label, COUNT(*) AS total " +
                          "FROM appointment GROUP BY MONTH(date) ORDER BY MONTH(date)";
                    title = "Monthly Appointments";
                    break;

                case "appointmentByGender":
                    sql = "SELECT s.gender AS label, COUNT(*) AS total " +
                          "FROM appointment a JOIN student s ON a.studentID = s.studentID " +
                          "GROUP BY s.gender";
                    title = "Appointments by Gender";
                    break;

                case "depressionLevels":
                    sql = "SELECT depressionResult AS label, COUNT(*) AS total " +
                          "FROM assessment GROUP BY depressionResult";
                    title = "Depression Level Distribution";
                    break;

                case "anxietyLevels":
                    sql = "SELECT anxietyResult AS label, COUNT(*) AS total " +
                          "FROM assessment GROUP BY anxietyResult";
                    title = "Anxiety Level Distribution";
                    break;

                case "stressLevels":
                    sql = "SELECT stressResult AS label, COUNT(*) AS total " +
                          "FROM assessment GROUP BY stressResult";
                    title = "Stress Level Distribution";
                    break;

                case "appointmentStatus":
                    sql = "SELECT status AS label, COUNT(*) AS total " +
                          "FROM appointment GROUP BY status";
                    title = "Appointment Status Breakdown";
                    break;

                case "assessments":
                    sql = "SELECT depressionResult, anxietyResult, stressResult, COUNT(*) AS total " +
                          "FROM assessment GROUP BY depressionResult, anxietyResult, stressResult";
                    try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            String combinedLabel = "D:" + rs.getString("depressionResult") +
                                                   ", A:" + rs.getString("anxietyResult") +
                                                   ", S:" + rs.getString("stressResult");
                            labels.add(combinedLabel);
                            values.add(rs.getInt("total"));
                            colors.add(randomColor());
                        }
                        data.setTitle("Combined DASS Result Distribution");
                        data.setLabels(labels);
                        data.setValues(values);
                        data.setColors(colors);
                        return data;
                    }

                default:
                    // fallback
                    data.setTitle("No data available");
                    data.setLabels(Arrays.asList("N/A"));
                    data.setValues(Arrays.asList(0));
                    data.setColors(Arrays.asList("#CCCCCC"));
                    return data;
            }

            // Execute general query
            try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    labels.add(rs.getString("label"));
                    values.add(rs.getInt("total"));
                    colors.add(randomColor());
                }
            }

            data.setTitle(title);
            data.setLabels(labels);
            data.setValues(values);
            data.setColors(colors);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return data;
    }

    private String randomColor() {
        Random rand = new Random();
        return String.format("#%06x", rand.nextInt(0xffffff + 1));
    }
}

