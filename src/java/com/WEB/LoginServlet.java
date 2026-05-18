/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.UserDAO;
import com.Model.User;
import com.Util.PasswordUtil;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Hash the input password before checking
        String hashedPassword = PasswordUtil.hashPassword(password);

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(username, hashedPassword);

        if (user == null) {
            request.setAttribute("errorMessage", "Invalid username or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return; // Ensure method exits after forward
        }

        // Store user session attributes
        HttpSession session = request.getSession();
        session.setAttribute("userID", user.getUserID());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("role", user.getRole());
        
        // Retrieve and store additional IDs based on role
        int roleID = userDAO.getRoleID(user.getUserID(), user.getRole());
        if (roleID > 0) {
            switch (user.getRole()) {
                case "student":
                    session.setAttribute("studentID", roleID);
                    break;
                case "counselor":
                    session.setAttribute("counselorID", roleID);
                    break;
                case "staff":
                    session.setAttribute("staffID", roleID);
                    break;
            }
        }        

        // Redirect based on user role
        switch (user.getRole()) {
            case "student":
                response.sendRedirect("StudentAppointmentBookingServlet?action=loadDashboard");
                break;
            case "counselor":
                response.sendRedirect("CounselorAppointmentServlet");
                break;
            case "staff":
                response.sendRedirect("StaffServlet?action=showDashboard");
                break;
            default:
                response.sendRedirect("login.jsp?error=Invalid role detected.");
                break;
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
