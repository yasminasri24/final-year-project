/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Staff;
import com.Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO {
    
    public String getLatestUsername(int userID) {
        String username = null;
        String sql = "SELECT username FROM user WHERE userID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return username;
    }

    public Staff getStaffByUserID(int userID) {
        Staff staff = null;
        String sql = "SELECT u.username, u.password, u.email, s.staffname, s.departmentS FROM user u "
                + "INNER JOIN staff s ON u.userID = s.userID WHERE u.userID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                staff = new Staff();
                staff.setUserID(userID);
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setEmail(rs.getString("email"));
                staff.setStaffname(rs.getString("staffname"));
                staff.setDepartmentS(rs.getString("departmentS"));
                return staff;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    // Update staff profile
    public boolean updateStaff(int userID, String username, String password, String email, String staffname, String departmentS) {
        String updateUserQuery = "UPDATE user SET username = ?, password = ?, email = ? WHERE userID = ?";
        String updateStaffQuery = "UPDATE staff SET staffname = ?, departmentS = ? WHERE userID = ?";

        try (Connection conn = DBConnection.getConnection();
         PreparedStatement updateUserStmt = conn.prepareStatement(updateUserQuery);
         PreparedStatement updateStaffStmt = conn.prepareStatement(updateStaffQuery);       ) {
            
            // Update User table
            updateUserStmt.setString(1, username);
            updateUserStmt.setString(2, password);
            updateUserStmt.setString(3, email);
            updateUserStmt.setInt(4, userID);
            updateUserStmt.executeUpdate();

            // Update Staff table
            updateStaffStmt.setString(1, staffname);
            updateStaffStmt.setString(2, departmentS);
            updateStaffStmt.setInt(3, userID);
            updateStaffStmt.executeUpdate();

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

    private Connection conn;

    public StaffDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    public int getTotalStudents() {
        String sql = "SELECT COUNT(*) FROM student";
        return getCount(sql);
    }

    public int getTotalCounselors() {
        String sql = "SELECT COUNT(*) FROM counselor";
        return getCount(sql);
    }

    public int getTotalStaff() {
        String sql = "SELECT COUNT(*) FROM staff";
        return getCount(sql);
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM user";
        return getCount(sql);
    }

    private int getCount(String sql) {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 in case of error
    }
}

