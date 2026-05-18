/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Counselor;

import com.DAO.CounselorDAO;
import com.Model.Counselor;
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
public class CounselorServlet extends HttpServlet {
    
    private CounselorDAO counselorDAO;

    @Override
    public void init() throws ServletException {
        counselorDAO = new CounselorDAO();
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
            showCounselorProfile(request, response);
        } else {
            showEditProfile(request, response);
        }
    }
    
    private void showCounselorProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Counselor counselor = counselorDAO.getCounselorByUserID(userID);

        if (counselor != null) {
            request.setAttribute("counselor", counselor);
            RequestDispatcher dispatcher = request.getRequestDispatcher("CounselorProfile.jsp");
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

        // Fetch student details
        Counselor counselor = counselorDAO.getCounselorByUserID(userID);

        if (counselor != null) {
            request.setAttribute("counselor", counselor);
            RequestDispatcher dispatcher = request.getRequestDispatcher("counselorProfile-edit.jsp");
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
       
        //Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String counselorname = request.getParameter("counselorname");
        String specialization = request.getParameter("specialization");
        String phoneC = request.getParameter("phoneC");
        
        // Hash password only if provided
        String hashedPassword = password.isEmpty() ? counselorDAO.getCurrentPassword(userID) : PasswordUtil.hashPassword(password);

        // Update staff details
        boolean success = counselorDAO.updateCounselor(userID, username, hashedPassword, email, counselorname, specialization, phoneC);
        
        if (success) {
            // Refresh session attributes to ensure they persist
            Counselor updatedCounselor = counselorDAO.getCounselorByUserID(userID);
            session.setAttribute("userID", userID); // Ensure userID remains in session
            session.setAttribute("username", updatedCounselor.getUsername()); 
            session.setAttribute("email", updatedCounselor.getEmail()); 
            session.setAttribute("counselorname", updatedCounselor.getCounselorname()); 
            session.setAttribute("specialization", updatedCounselor.getSpecialization()); 
            session.setAttribute("phoneC", updatedCounselor.getPhoneC()); 

            request.getSession().setAttribute("message", "Profile updated successfully!");
            response.sendRedirect("CounselorServlet?action=profile");
        } else {
            request.getSession().setAttribute("errorMessage", "Profile update failed!");
            response.sendRedirect("CounselorServlet?action=profile");
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
