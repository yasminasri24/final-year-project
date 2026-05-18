/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.User;
import com.Util.DBConnection;
import static com.Util.DBConnection.getConnection;
import com.Util.PasswordUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    //Register User
    public int registerUser(User user) {
        int userID = -1; // Default value if registration fails

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO user (username, password, email, role) VALUES (?, ?, ?, ?)", 
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, PasswordUtil.hashPassword(user.getPassword())); // Hash password
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve the generated userID
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    userID = rs.getInt(1); // Store the userID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userID; // Return generated userID
    }

    //Student data
    public boolean insertStudent(int userID, String studentname, String program, int year, String gender, String phoneS) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO student (userID, studentname, program, year, gender, phoneS) VALUES (?, ?, ?, ?, ?, ?)")) {
            
            ps.setInt(1, userID);
            ps.setString(2, studentname);
            ps.setString(3, program);
            ps.setInt(4, year);
            ps.setString(5, gender);
            ps.setString(6, phoneS);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Counselor data
    public boolean insertCounselor(int userID, String counselorname, String specialization, String phoneC) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO counselor (userID, counselorname, specialization, phoneC) VALUES (?, ?, ?, ?)")) {
            
            ps.setInt(1, userID);
            ps.setString(2, counselorname);
            ps.setString(3, specialization);
            ps.setString(4, phoneC);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Staff data
    public boolean insertStaff(int userID, String staffname, String departmentS) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO staff (userID, staffname, departmentS) VALUES (?, ?, ?)")) {
            
            ps.setInt(1, userID);
            ps.setString(2, staffname);
            ps.setString(3, departmentS);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //Login user
    public User loginUser(String username, String password) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE username = ?")) {
            
             ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                System.out.println("Debug: Username found, checking password...");

                if (password.equals(storedHashedPassword)) { // No extra hashing
                    User user = new User();
                    user.setUserID(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    return user;
                } else {
                    System.out.println("Debug: Password does not match.");
                }
            } else {
                System.out.println("Debug: Username not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Invalid credentials
    }
    
    //Validate user
    public User validateUser(String username, String hashedPassword) {
        User user = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE username = ? AND password = ?")) {

            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            System.out.println("Debug: Checking user -> Username: " + username);
            System.out.println("Debug: Hashed password sent: " + hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Debug: User found in database!");

                user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            } else {
                System.out.println("Debug: No matching user found in database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public int getRoleID(int userID, String role) {
        int roleID = -1;
        String query = "";

        switch (role) {
            case "student":
                query = "SELECT studentID FROM student WHERE userID = ?";
                break;
            case "counselor":
                query = "SELECT counselorID FROM counselor WHERE userID = ?";
                break;
            case "staff":
                query = "SELECT staffID FROM staff WHERE userID = ?";
                break;
            default:
                return -1; // Invalid role
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                roleID = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roleID;
    }
    
    //Display list of users
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM user");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    //Get user by ID
    public User getUserByID(int userID) {
        User user = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE userID = ?")) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    //Update user
    public boolean updateUser(int userID, String username, String email) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE user SET username=?, email=? WHERE userID=?")) {

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setInt(3, userID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //Delete User
    public boolean deleteUser(int userID) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM user WHERE userID=?")) {

            ps.setInt(1, userID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //Get User Email by Student ID
    public String getUserEmailByStudentID(int studentID) throws SQLException {
        String email = null;
        String sql = "SELECT u.email FROM user u " +
                     "JOIN student s ON u.userID = s.userID " +
                     "WHERE s.studentID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        }
        return email;
    }
    
    //Get User Email by Counselor ID
    public String getUserEmailByCounselorID(int counselorID) throws SQLException {
        String email = null;
        String sql = "SELECT u.email FROM user u " +
                     "JOIN counselor c ON u.userID = c.userID " +
                     "WHERE c.counselorID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        }
        return email;
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePasswordByEmail(String email, String hashedPassword) {
        String sql = "UPDATE user SET password = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}

