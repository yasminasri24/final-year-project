/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.AssessmentDAO;
import com.Util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class AssessmentServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int assessmentID = Integer.parseInt(request.getParameter("assessmentID"));

        try (Connection conn = DBConnection.getConnection()) {
            AssessmentDAO assessmentDAO = new AssessmentDAO(conn);
            assessmentDAO.deleteAssessment(assessmentID);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("assessment-staff.jsp"); // Redirect back to assessment list
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
