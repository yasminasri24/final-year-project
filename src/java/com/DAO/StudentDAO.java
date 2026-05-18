/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Appointment;
import com.Model.Student;
import com.Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DELL
 */
public class StudentDAO {
    
    public Student getStudentByUserID(int userID) {
        Student student = null;
        String sql = "SELECT u.username, u.password, u.email, s.studentname, s.program, s.year, s.gender, s.phoneS FROM user u "
                + "INNER JOIN student s ON u.userID = s.userID WHERE u.userID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setUserID(userID);
                student.setUsername(rs.getString("username"));
                student.setPassword(rs.getString("password"));
                student.setEmail(rs.getString("email"));
                student.setStudentName(rs.getString("studentname"));
                student.setProgram(rs.getString("program"));
                student.setYear(rs.getInt("year"));
                student.setGender(rs.getString("gender"));
                student.setPhoneS(rs.getString("phoneS"));
                return student;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }

    // Update student profile
    public boolean updateStudent(int userID, String username, String password, String email, String studentname, String program, int year, String gender, String phoneS) {
        String updateUserQuery = "UPDATE user SET username = ?, password = ?, email = ? WHERE userID = ?";
        String updateStudentQuery = "UPDATE student SET studentname = ?, program = ?, year = ?, gender = ?, phoneS = ? WHERE userID = ?";

        try (Connection conn = DBConnection.getConnection();
         PreparedStatement updateUserStmt = conn.prepareStatement(updateUserQuery);
         PreparedStatement updateStudentStmt = conn.prepareStatement(updateStudentQuery);       ) {
            
            // Update User table
            updateUserStmt.setString(1, username);
            updateUserStmt.setString(2, password);
            updateUserStmt.setString(3, email);
            updateUserStmt.setInt(4, userID);
            updateUserStmt.executeUpdate();

            // Update Student table
            updateStudentStmt.setString(1, studentname);
            updateStudentStmt.setString(2, program);
            updateStudentStmt.setInt(3, year);
            updateStudentStmt.setString(4, gender);
            updateStudentStmt.setString(5, phoneS);
            updateStudentStmt.setInt(6, userID);
            updateStudentStmt.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public String getCurrentPassword(int userID) {
        String password = null;
        String sql = "SELECT password FROM user WHERE userID = ?"; // Assuming 'User' table stores passwords

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                password = rs.getString("password");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return password;
    }
         
    public boolean deleteStudentProfile(int userID) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
        // Delete from the student table first
            String deleteStudentQuery = "DELETE FROM student WHERE userID = ?";
            PreparedStatement studentStatement = conn.prepareStatement(deleteStudentQuery);
            studentStatement.setInt(1, userID);
            int studentDeleteCount = studentStatement.executeUpdate();

            // If the student record is deleted, now delete from the user table
            if (studentDeleteCount > 0) {
                String deleteUserQuery = "DELETE FROM user WHERE userID = ?";
                PreparedStatement userStatement = conn.prepareStatement(deleteUserQuery);
                userStatement.setInt(1, userID);
                int userDeleteCount = userStatement.executeUpdate();

                return userDeleteCount > 0;
            } else {
                return false;
            }
            } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static Student getStudentById(int studentID) {
        Student student = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM student WHERE studentID = ?")) {

            ps.setInt(1, studentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                student = new Student();
                student.setStudentID(rs.getInt("studentID"));
                student.setStudentName(rs.getString("studentname"));
                student.setEmail(rs.getString("email"));
                // Add other fields as needed
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }
}
      
   
   