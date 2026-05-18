/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.UserDAO;
import com.Model.User;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword"); // Get confirmPassword
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        
        // Backend validation: Ensure passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
            dispatcher.forward(request, response);
            return; // Stop execution
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRole(role);

        UserDAO userDAO = new UserDAO();
        int userID = userDAO.registerUser(user); // Insert into User table and get userID

        boolean success = false;
        
        if (userID > 0) {
            switch (role) {
                case "student":
                    String studentname = request.getParameter("studentname");
                    String program = request.getParameter("program");
                    int year = Integer.parseInt(request.getParameter("year"));
                    String gender = request.getParameter("gender");
                    String phoneS = request.getParameter("phoneS");
                    success = userDAO.insertStudent(userID, studentname, program, year, gender, phoneS);
                    break;

                case "counselor":
                    String counselorname = request.getParameter("counselorname");
                    String specialization = request.getParameter("specialization");
                    String phoneC = request.getParameter("phoneC");
                    success = userDAO.insertCounselor(userID, counselorname, specialization, phoneC);
                    break;

                case "staff":
                    String staffname = request.getParameter("staffname");
                    String departmentS = request.getParameter("departmentS");
                    success = userDAO.insertStaff(userID, staffname, departmentS);
                    break;
            }
        }

        if (success) {
            request.getSession().setAttribute("userEmail", email);
            request.getSession().setAttribute("message", "Registration successful. Please log in.");
            response.sendRedirect("login.jsp");
        } else {
            request.getSession().setAttribute("message", "Registration failed. Try again.");
            response.sendRedirect("signin.jsp");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
