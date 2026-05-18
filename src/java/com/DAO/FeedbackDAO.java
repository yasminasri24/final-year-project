/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Feedback;
import com.Util.DBConnection;

import java.sql.*;
import java.util.*;

public class FeedbackDAO {

    public void insertFeedback(Feedback fb) {
        String sql = "INSERT INTO feedback (appointmentID, studentID, rating, comments) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fb.getAppointmentID());
            ps.setInt(2, fb.getStudentID());
            ps.setInt(3, fb.getRating());
            ps.setString(4, fb.getComments());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFeedback(Feedback fb) {
        String sql = "UPDATE feedback SET rating=?, comments=? WHERE appointmentID=? AND studentID=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fb.getRating());
            ps.setString(2, fb.getComments());
            ps.setInt(3, fb.getAppointmentID());
            ps.setInt(4, fb.getStudentID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteFeedback(int appointmentID, int studentID) {
        String sql = "DELETE FROM feedback WHERE appointmentID=? AND studentID=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentID);
            ps.setInt(2, studentID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedbackByAppointmentID(int appointmentID) {
        Feedback fb = null;
        String sql = "SELECT * FROM feedback WHERE appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fb = new Feedback();
                fb.setAppointmentID(rs.getInt("appointmentID"));
                fb.setStudentID(rs.getInt("studentID"));
                fb.setRating(rs.getInt("rating"));
                fb.setComments(rs.getString("comments"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fb;
    }

    public boolean isFeedbackSubmitted(int appointmentID) {
        String sql = "SELECT 1 FROM feedback WHERE appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Get feedback for counselor
    public List<Feedback> getFeedbackByCounselor(int counselorID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, s.studentname, a.date, a.time " +
                     "FROM feedback f " +
                     "JOIN appointment a ON f.appointmentID = a.appointmentID " +
                     "JOIN student s ON f.studentID = s.studentID " +
                     "WHERE a.counselorID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, counselorID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setAppointmentID(rs.getInt("appointmentID"));
                fb.setStudentID(rs.getInt("studentID"));
                fb.setRating(rs.getInt("rating"));
                fb.setComments(rs.getString("comments"));
                fb.setStudentname(rs.getString("studentname")); // Add this to your Feedback model
                fb.setDate(rs.getDate("date"));
                fb.setTime(rs.getTime("time"));
                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    //Get all feddback for admin
    public List<Feedback> getAllFeedback(String counselorName) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, s.studentname, c.counselorname, a.date, a.time " +
                     "FROM feedback f " +
                     "JOIN appointment a ON f.appointmentID = a.appointmentID " +
                     "JOIN student s ON f.studentID = s.studentID " +
                     "JOIN counselor c ON a.counselorID = c.counselorID ";

        if (counselorName != null && !counselorName.trim().isEmpty()) {
            sql += "WHERE c.counselorname LIKE ?";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (counselorName != null && !counselorName.trim().isEmpty()) {
                ps.setString(1, "%" + counselorName + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setAppointmentID(rs.getInt("appointmentID"));
                fb.setStudentID(rs.getInt("studentID"));
                fb.setRating(rs.getInt("rating"));
                fb.setComments(rs.getString("comments"));
                fb.setStudentname(rs.getString("studentname"));
                fb.setCounselorname(rs.getString("counselorname"));
                fb.setDate(rs.getDate("date"));
                fb.setTime(rs.getTime("time"));
                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}