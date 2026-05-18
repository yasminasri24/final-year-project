/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.AssessmentResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class AssessmentResponseDAO {
    
    private final Connection conn;

    public AssessmentResponseDAO(Connection conn) {
        this.conn = conn;
    }

    // Insert a single response into the database
    public void saveResponse(AssessmentResponse response) throws SQLException {
        String sql = "INSERT INTO assessmentresponse (studentID, assessmentID, questionID, response) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, response.getStudentID());
            stmt.setInt(2, response.getAssessmentID());
            stmt.setInt(3, response.getQuestionID());
            stmt.setInt(4, response.getResponse());

            stmt.executeUpdate();  // Execute the query
        }
    }

    // Insert multiple responses at once
    public void saveResponses(List<AssessmentResponse> responses) throws SQLException {
        String sql = "INSERT INTO assessmentresponse (studentID, assessmentID, questionID, response) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (AssessmentResponse response : responses) {
                stmt.setInt(1, response.getStudentID());
                stmt.setInt(2, response.getAssessmentID());
                stmt.setInt(3, response.getQuestionID());
                stmt.setInt(4, response.getResponse());
                stmt.addBatch();
            }
            stmt.executeBatch();  // Execute batch insert
        }
    }

    // Retrieve responses for a given assessment
    public List<AssessmentResponse> getResponses(int assessmentID) throws SQLException {
        List<AssessmentResponse> responses = new ArrayList<>();
        String sql = "SELECT * FROM assessmentresponse WHERE assessmentID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, assessmentID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AssessmentResponse response = new AssessmentResponse();
                    response.setResponseID(rs.getInt("responseID"));
                    response.setStudentID(rs.getInt("studentID"));
                    response.setAssessmentID(rs.getInt("assessmentID"));
                    response.setQuestionID(rs.getInt("questionID"));
                    response.setResponse(rs.getInt("response"));
                    responses.add(response);
                }
            }
        }
        return responses;
    }
}