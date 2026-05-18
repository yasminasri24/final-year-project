/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Staff;

import com.DAO.StaffDAO;
import com.Model.Staff;
import com.Util.PasswordUtil;
import java.io.IOException;
import java.sql.SQLException;
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
public class StaffServlet extends HttpServlet {

    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        try {
            staffDAO = new StaffDAO();
        } catch (SQLException e) {
            throw new ServletException("Database connection error in StaffDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        // Redirect to login if session is null
        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Check action and forward accordingly
        String action = request.getParameter("action");
        if ("profile".equals(action)) {
            showStaffProfile(request, response);
        } else if ("editProfile".equals(action)) {
            showEditProfile(request, response);
        } else {
            showDashboard(request, response);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID != null) {
            // Fetch latest username from the database
            String latestUsername = staffDAO.getLatestUsername(userID);
            if (latestUsername != null) {
                session.setAttribute("username", latestUsername);
            }
        }

        // Fetch counts
        int studentCount = staffDAO.getTotalStudents();
        int counselorCount = staffDAO.getTotalCounselors();
        int staffCount = staffDAO.getTotalStaff();
        int totalUsers = staffDAO.getTotalUsers();

        // Store in session
        session.setAttribute("studentCount", studentCount);
        session.setAttribute("counselorCount", counselorCount);
        session.setAttribute("staffCount", staffCount);
        session.setAttribute("totalUsers", totalUsers);

        // Redirect to dashboard JSP
        request.getRequestDispatcher("staffDashboard_info.jsp").forward(request, response);
    }
    
    private void showStaffProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Staff staff = staffDAO.getStaffByUserID(userID);

        if (staff != null) {
            request.setAttribute("staff", staff);
            RequestDispatcher dispatcher = request.getRequestDispatcher("StaffProfile.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
    
    private void showEditProfile(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch staff details
        Staff staff = staffDAO.getStaffByUserID(userID);

        if (staff != null) {
            request.setAttribute("staff", staff);
            RequestDispatcher dispatcher = request.getRequestDispatcher("staffProfile-edit.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Optional field
        String email = request.getParameter("email");
        String staffname = request.getParameter("staffname");
        String departmentS = request.getParameter("departmentS");

        // Hash password only if provided
        String hashedPassword = password.isEmpty() ? staffDAO.getCurrentPassword(userID) : PasswordUtil.hashPassword(password);

        // Update staff details
        boolean success = staffDAO.updateStaff(userID, username, hashedPassword, email, staffname, departmentS);

        if (success) {
            // Refresh session attributes to ensure they persist
            Staff updatedStaff = staffDAO.getStaffByUserID(userID);
            session.setAttribute("userID", userID); // Ensure userID remains in session
            session.setAttribute("username", updatedStaff.getUsername()); 
            session.setAttribute("email", updatedStaff.getEmail()); 
            session.setAttribute("staffname", updatedStaff.getStaffname()); 
            session.setAttribute("departmentS", updatedStaff.getDepartmentS()); 

            request.getSession().setAttribute("message", "Profile updated successfully!");
            response.sendRedirect("StaffServlet?action=profile");
        } else {
            request.getSession().setAttribute("errorMessage", "Profile update failed!");
            response.sendRedirect("StaffServlet?action=profile");
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
