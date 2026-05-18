/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Question;
import com.Util.DBConnection;
import java.sql.*;
import java.util.*;

/**
 *
 * @author DELL
 */
public class QuestionDAO {
    
    //Display list of users
    public List<Question> getAllQuestions() {
        List<Question> questionList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM question");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Question question = new Question();
                question.setQuestionID(rs.getInt("questionID"));
                question.setQuestionText(rs.getString("questionText"));
                question.setWeight(rs.getInt("weight"));
                question.setCategory(rs.getString("category"));

                questionList.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questionList;
    }
        
    //Get question by ID
    public Question getQuestionByID(int questionID) {
        Question question = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM question WHERE questionID = ?")) {

            ps.setInt(1, questionID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                question = new Question();
                question.setQuestionID(rs.getInt("questionID"));
                question.setQuestionText(rs.getString("questionText"));
                question.setWeight(rs.getInt("weight"));
                question.setCategory(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return question;
    }
    
    public boolean addQuestion(String questionText, int weight, String category) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO question (questionText, weight, category) VALUES (?, ?, ?)")) {

            ps.setString(1, questionText);
            ps.setInt(2, weight);
            ps.setString(3, category);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateQuestion(int questionID, String questionText, int weight, String category) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE question SET questionText=?, weight=?, category=? WHERE questionID=?")) {

            ps.setString(1, questionText);
            ps.setInt(2, weight);
            ps.setString(3, category);
            ps.setInt(4, questionID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteQuestion(int questionID) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM question WHERE questionID=?")) {

            ps.setInt(1, questionID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

