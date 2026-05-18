/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Counselor;
import com.Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DELL
 */
public class CounselorDAO {
        
    public Counselor getCounselorByUserID(int userID) {
        Counselor counselor = null;
        String sql = "SELECT u.username, u.password, u.email, c.counselorname, c.specialization, c.phoneC FROM user u "
                + "INNER JOIN counselor c ON u.userID = c.userID WHERE u.userID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                counselor = new Counselor();
                counselor.setUserID(userID);
                counselor.setUsername(rs.getString("username"));
                counselor.setPassword(rs.getString("password"));
                counselor.setEmail(rs.getString("email"));
                counselor.setCounselorname(rs.getString("counselorname"));
                counselor.setSpecialization(rs.getString("specialization"));
                counselor.setPhoneC(rs.getString("phoneC"));
                return counselor;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counselor;
    }
    
    // Update counselor profile
    public boolean updateCounselor(int userID, String username, String password, String email, String counselorname, String specialization, String phoneC) {
        String updateUserQuery = "UPDATE user SET username = ?, password = ?, email = ? WHERE userID = ?";
        String updateCounselorQuery = "UPDATE counselor SET counselorname = ?, specialization = ?, phoneC = ? WHERE userID = ?";

        try (Connection conn = DBConnection.getConnection();
         PreparedStatement updateUserStmt = conn.prepareStatement(updateUserQuery);
         PreparedStatement updateCounselorStmt = conn.prepareStatement(updateCounselorQuery);       ) {
            
            // Update User table
            updateUserStmt.setString(1, username);
            updateUserStmt.setString(2, password);
            updateUserStmt.setString(3, email);
            updateUserStmt.setInt(4, userID);
            updateUserStmt.executeUpdate();

            // Update Student table
            updateCounselorStmt.setString(1,counselorname);
            updateCounselorStmt.setString(2, specialization);
            updateCounselorStmt.setString(3, phoneC);
            updateCounselorStmt.setInt(4, userID);
            updateCounselorStmt.executeUpdate();

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
    
    public boolean deleteCounselorProfile(int userID) throws SQLException {
        // Delete from the counselor table first
        try (Connection conn = DBConnection.getConnection()) {
            String deleteCounselorQuery = "DELETE FROM counselor WHERE userID = ?";
            PreparedStatement counselorStatement = conn.prepareStatement(deleteCounselorQuery);
            counselorStatement.setInt(1, userID);
            int counselorDeleteCount = counselorStatement.executeUpdate();

            // If the counselor record is deleted, now delete from the user table
            if (counselorDeleteCount > 0) {
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
   
    public Counselor getCounselorByID(int counselorID) throws Exception {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM counselor WHERE counselorID = ?";
        Counselor counselor = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    counselor = new Counselor();
                    counselor.setCounselorID(rs.getInt("counselorID"));
                    counselor.setCounselorname(rs.getString("counselorname"));
                    counselor.setPhoneC(rs.getString("phoneC"));
                    counselor.setSpecialization(rs.getString("specialization"));
                }
            }
        }
        return counselor;
    }
    
}
   
