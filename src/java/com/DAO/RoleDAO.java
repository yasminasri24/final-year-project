/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author DELL
 */
public class RoleDAO {
    
    public boolean insertStudentDetails(Connection conn, int userID, Object[] details) {
        String query = "INSERT INTO student (userID, studentname, program, year, gender, phoneS) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userID);
            stmt.setString(2, (String) details[0]); // studentname
            stmt.setString(3, (String) details[1]); // program
            stmt.setInt(4, (Integer) details[2]);  // year
            stmt.setString(5, (String) details[3]); // gender
            stmt.setString(6, (String) details[4]); // phone
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertCounselorDetails(Connection conn, int userID, Object[] details) {
        String query = "INSERT INTO counselor (userID, counselorname, specialization, phoneC) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userID);
            stmt.setString(2, (String) details[0]); // counselorname
            stmt.setString(3, (String) details[1]); // specialization
            stmt.setString(4, (String) details[2]); // department
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertStaffDetails(Connection conn, int userID, Object[] details) {
        String query = "INSERT INTO staff (userID, staffname, departmentS) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userID);
            stmt.setString(2, (String) details[0]); // staffname
            stmt.setString(3, (String) details[1]); // department
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

   
