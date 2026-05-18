/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Student;

import com.DAO.StudentDAO;
import com.Model.Student;
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
public class StudentServlet extends HttpServlet {
    
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
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
            showStudentProfile(request, response);
        } else {
            showEditProfile(request, response);
        }
    }
    
    private void showStudentProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Student student = studentDAO.getStudentByUserID(userID);

        if (student != null) {
            request.setAttribute("student", student);
            RequestDispatcher dispatcher = request.getRequestDispatcher("StudentProfile.jsp");
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
        Student student = studentDAO.getStudentByUserID(userID);

        if (student != null) {
            request.setAttribute("student", student);
            RequestDispatcher dispatcher = request.getRequestDispatcher("studentProfile-edit.jsp");
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
        String studentname = request.getParameter("studentname");
        String program = request.getParameter("program");
        int year = Integer.parseInt(request.getParameter("year"));
        String gender = request.getParameter("gender");
        String phoneS = request.getParameter("phoneS");
        
        // Hash password only if provided
        String hashedPassword = password.isEmpty() ? studentDAO.getCurrentPassword(userID) : PasswordUtil.hashPassword(password);

        // Update staff details
        boolean success = studentDAO.updateStudent(userID, username, hashedPassword, email, studentname, program, year, gender, phoneS);
        
        if (success) {
            // Refresh session attributes to ensure they persist
            Student updatedStudent = studentDAO.getStudentByUserID(userID);
            session.setAttribute("userID", userID); // Ensure userID remains in session
            session.setAttribute("username", updatedStudent.getUsername()); 
            session.setAttribute("email", updatedStudent.getEmail()); 
            session.setAttribute("studentname", updatedStudent.getStudentName()); 
            session.setAttribute("program", updatedStudent.getProgram()); 
            session.setAttribute("year", updatedStudent.getYear()); 
            session.setAttribute("gender", updatedStudent.getGender()); 
            session.setAttribute("phoneS", updatedStudent.getPhoneS()); 

            request.getSession().setAttribute("message", "Profile updated successfully!");
            response.sendRedirect("StudentServlet?action=profile");
        } else {
            request.getSession().setAttribute("errorMessage", "Profile update failed!");
            response.sendRedirect("StudentServlet?action=profile");
        }
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
