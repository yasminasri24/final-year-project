/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Assessment;
import com.Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class AssessmentDAO {
    
    private final Connection conn;

    // Constructor to initialize the connection
    public AssessmentDAO(Connection conn) {
        this.conn = conn;
    }
    
    public void save(Assessment assessment) throws SQLException {
        String insertSQL = "INSERT INTO assessment (studentID, depressionScore, anxietyScore, stressScore, "
                + "depressionResult, anxietyResult, stressResult, recommendation, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, assessment.getStudentID());
            stmt.setInt(2, assessment.getDepressionScore());
            stmt.setInt(3, assessment.getAnxietyScore());
            stmt.setInt(4, assessment.getStressScore());
            stmt.setString(5, assessment.getDepressionResult());
            stmt.setString(6, assessment.getAnxietyResult());
            stmt.setString(7, assessment.getStressResult());
            stmt.setString(8, assessment.getRecommendation());
            stmt.setString(9, assessment.getStatus());

            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                // If the insert is successful, get the generated assessmentID
                try (ResultSet rs = stmt.getGeneratedKeys()) { // Use ResultSet explicitly instead of var
                    if (rs.next()) {
                        int assessmentID = rs.getInt(1);
                        assessment.setAssessmentID(assessmentID);  // Set the generated assessmentID
                    }
                }
            } else {
                throw new SQLException("Creating assessment failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new SQLException("Error saving assessment result", e);
        }
    }
    
    public boolean update(Assessment assessment) throws SQLException {
        String sql = "UPDATE assessment SET depressionScore = ?, anxietyScore = ?, stressScore = ?, " +
                     "depressionResult = ?, anxietyResult = ?, stressResult = ?, recommendation = ?, status = ? " +
                     "WHERE assessmentID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, assessment.getDepressionScore());
            stmt.setInt(2, assessment.getAnxietyScore());
            stmt.setInt(3, assessment.getStressScore());
            stmt.setString(4, assessment.getDepressionResult());
            stmt.setString(5, assessment.getAnxietyResult());
            stmt.setString(6, assessment.getStressResult());
            stmt.setString(7, assessment.getRecommendation());
            stmt.setString(8, assessment.getStatus());
            stmt.setInt(9, assessment.getAssessmentID()); // Updating based on assessmentID

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Returns true if the update was successful
        }
    }
    
    public Assessment getLatestAssessmentByStudentID(int studentID) throws SQLException {
        String sql = "SELECT * FROM assessment WHERE studentID = ? ORDER BY date DESC, assessmentID DESC LIMIT 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Assessment assessment = new Assessment();
                    assessment.setAssessmentID(rs.getInt("assessmentID"));
                    assessment.setStudentID(rs.getInt("studentID"));
                    assessment.setDepressionScore(rs.getInt("depressionScore"));
                    assessment.setAnxietyScore(rs.getInt("anxietyScore"));
                    assessment.setStressScore(rs.getInt("stressScore"));
                    assessment.setDepressionResult(rs.getString("depressionResult"));
                    assessment.setAnxietyResult(rs.getString("anxietyResult"));
                    assessment.setStressResult(rs.getString("stressResult"));
                    assessment.setRecommendation(rs.getString("recommendation"));
                    assessment.setStatus(rs.getString("status"));
                    return assessment;
                }
            }
        }
        return null; // No assessment found
    }
    
    public List<Assessment> getAllAssessments() throws SQLException {
        List<Assessment> assessments = new ArrayList<>();
        String sql = "SELECT a.*, s.studentname FROM assessment a " +
                     "JOIN student s ON a.studentID = s.studentID " +
                     "ORDER BY a.date DESC, a.assessmentID DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Assessment assessment = new Assessment();
                assessment.setAssessmentID(rs.getInt("assessmentID"));
                assessment.setStudentID(rs.getInt("studentID"));
                assessment.setStudentname(rs.getString("studentname")); // Add student name
                assessment.setDate(rs.getDate("date"));
                assessment.setDepressionScore(rs.getInt("depressionScore"));
                assessment.setAnxietyScore(rs.getInt("anxietyScore"));
                assessment.setStressScore(rs.getInt("stressScore"));
                assessment.setDepressionResult(rs.getString("depressionResult"));
                assessment.setAnxietyResult(rs.getString("anxietyResult"));
                assessment.setStressResult(rs.getString("stressResult"));
                assessment.setRecommendation(rs.getString("recommendation"));
                assessment.setStatus(rs.getString("status"));
                assessments.add(assessment);
            }
        }
        return assessments;
    }
    
    public void deleteAssessment(int assessmentID) throws SQLException {
        String sql = "DELETE FROM assessment WHERE assessmentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, assessmentID);
            stmt.executeUpdate();
        }
    }
    
    public Assessment getRecentAssessmentByStudentID(int studentID) {
        String sql = "SELECT * FROM assessment WHERE studentID = ? ORDER BY date DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Assessment a = new Assessment();
                a.setAssessmentID(rs.getInt("assessmentID"));
                a.setStudentID(rs.getInt("studentID"));
                a.setDate(rs.getDate("date"));
                a.setDepressionScore(rs.getInt("depressionScore"));
                a.setAnxietyScore(rs.getInt("anxietyScore"));
                a.setStressScore(rs.getInt("stressScore"));
                a.setDepressionResult(rs.getString("depressionResult"));
                a.setAnxietyResult(rs.getString("anxietyResult"));
                a.setStressResult(rs.getString("stressResult"));
                a.setRecommendation(rs.getString("recommendation"));
                a.setStatus(rs.getString("status"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
