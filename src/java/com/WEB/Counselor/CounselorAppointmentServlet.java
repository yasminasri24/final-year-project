/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Counselor;

import com.DAO.AppointmentDAO;
import com.DAO.AssessmentDAO;
import com.Model.Appointment;
import com.Model.Assessment;
import com.Util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.Comparator;
import java.text.SimpleDateFormat;

/**
 *
 * @author DELL
 */
public class CounselorAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Object counselorIdObj = session.getAttribute("counselorID");

        if (counselorIdObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int counselorID;
        try {
            counselorID = (counselorIdObj instanceof String)
                ? Integer.parseInt((String) counselorIdObj)
                : (int) counselorIdObj;
        } catch (Exception e) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            int countConfirmed = appointmentDAO.countAppointmentsByStatus(counselorID, "Confirmed");
            int countCompleted = appointmentDAO.countAppointmentsByStatus(counselorID, "Completed");
            int countRejected = appointmentDAO.countAppointmentsByStatus(counselorID, "Rejected");

            int personalCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Personal");
            int academicCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Academic");
            int mentalCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Mental Health");
            int financeCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Finance");
            int socialCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Social");
            int careerCount = appointmentDAO.countAppointmentsByCategory(counselorID, "Career");

            request.setAttribute("countConfirmed", countConfirmed);
            request.setAttribute("countCompleted", countCompleted);
            request.setAttribute("countRejected", countRejected);

            request.setAttribute("personalCount", personalCount);
            request.setAttribute("academicCount", academicCount);
            request.setAttribute("mentalCount", mentalCount);
            request.setAttribute("financeCount", financeCount);
            request.setAttribute("socialCount", socialCount);
            request.setAttribute("careerCount", careerCount);      
         } catch (Exception e) {
                e.printStackTrace(); // Optional: log to file
                response.sendRedirect("error.jsp");
                return;
         }

       
        String action = request.getParameter("action");
        if ("noteform".equals(action)) {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            Appointment appt = new AppointmentDAO().getAppointmentByID(appointmentID);
            request.setAttribute("appointment", appt);
            request.getRequestDispatcher("add-notes.jsp").forward(request, response);
            return;
        } else if ("viewAssessment".equals(action)) {
            String studentIdStr = request.getParameter("studentID");

            if (studentIdStr == null || studentIdStr.isEmpty()) {
                response.sendRedirect("error.jsp"); // or display a friendly message
                return;
            }

            int studentID;
            try {
                studentID = Integer.parseInt(studentIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("error.jsp");
                return;
            }

            try (Connection conn = DBConnection.getConnection()) {
                AssessmentDAO assessmentDAO = new AssessmentDAO(conn);
                Assessment result = assessmentDAO.getRecentAssessmentByStudentID(studentID);

                request.setAttribute("assessment", result);
                request.getRequestDispatcher("view-assessment.jsp").forward(request, response);
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
                return;
            }
            
        } else if ("calendar".equals(request.getParameter("view"))) {
            List<Appointment> allAppointments = new AppointmentDAO().getConfirmedAppointmentsByCounselorId(counselorID);
            request.setAttribute("appointments", allAppointments);
            request.getRequestDispatcher("counselor-calendar.jsp").forward(request, response);
            return;
        }

        String search = request.getParameter("search");
        String statusFilter = request.getParameter("statusFilter");
        String view = request.getParameter("view");

        AppointmentDAO dao = new AppointmentDAO();

        try {
            List<Appointment> todaysAppointments = dao.getTodaysAppointments(counselorID);
            List<Appointment> pendingTasks = dao.getPendingAppointments(counselorID);
            
            request.setAttribute("pendingTasks", pendingTasks);
            request.setAttribute("todaysAppointments", todaysAppointments);
            
            List<Appointment> confirmedAppointments = dao.getConfirmedAppointmentsByCounselorId(counselorID);
            request.setAttribute("appointments", confirmedAppointments);
            
            // Sort pendingTasks by latest datetime (descending)
            Collections.sort(pendingTasks, new Comparator<Appointment>() {
                @Override
                public int compare(Appointment a1, Appointment a2) {
                    try {
                        String dateTimeStr1 = a1.getDate().toString() + " " + a1.getTime(); // "2025-08-05 15:40:00"
                        String dateTimeStr2 = a2.getDate().toString() + " " + a2.getTime(); // "2025-08-05 17:40:00"

                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                        java.util.Date dt1 = sdf.parse(dateTimeStr1);
                        java.util.Date dt2 = sdf.parse(dateTimeStr2);

                        return dt2.compareTo(dt1); // Latest first
                    } catch (Exception e) {
                        e.printStackTrace();
                        return 0;
                    }
                }
            });

            String target = request.getParameter("view");
            if ("all".equals(target)) {
                List<Appointment> filteredAppointments = dao.getFilteredAppointments(counselorID, search, statusFilter);
                request.setAttribute("appointments", filteredAppointments);
                request.getRequestDispatcher("counselor-appointments.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("counselorDashboard.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace(); // For debugging, log this
            response.sendRedirect("error.jsp"); // Optionally show error page
        }    
    }

        
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        AppointmentDAO dao = new AppointmentDAO();

        if ("confirm".equals(action)) {
            dao.updateAppointmentStatus(appointmentID, "Confirmed");
        } else if ("reject".equals(action)) {
            dao.updateAppointmentStatus(appointmentID, "Rejected");
        } else if ("complete".equals(action)) {
            dao.updateAppointmentStatus(appointmentID, "Completed");
        } else if ("submitnote".equals(action)) {
            appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            String notes = request.getParameter("notes");

            boolean saved = dao.updateAppointmentNotes(appointmentID, notes);

            if (saved) {
                request.getSession().setAttribute("noteMessage", "Session notes saved successfully.");
            } else {
                request.getSession().setAttribute("noteMessage", "Failed to save notes. Please try again.");
            }

            response.sendRedirect("CounselorAppointmentServlet?view=all");
            return;
        }

        response.sendRedirect("CounselorAppointmentServlet"); 
    }

        
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
