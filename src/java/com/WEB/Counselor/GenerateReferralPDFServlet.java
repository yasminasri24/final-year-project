/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Counselor;

import com.DAO.AppointmentDAO;
import com.DAO.CounselorDAO;
import com.DAO.StudentDAO;
import com.Model.Appointment;
import com.Model.Counselor;
import com.Model.Student;
import com.Util.ReferralPDFGenerator;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class GenerateReferralPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentParam = request.getParameter("studentID");
        String counselorParam = request.getParameter("counselorID");
        String appointmentParam = request.getParameter("appointmentID");

        // Optional fields from form
        String referralTo = request.getParameter("referralTo");
        String reason = request.getParameter("reason");
        String notes = request.getParameter("notes");

        // Debugging
        System.out.println("studentID: " + studentParam);
        System.out.println("counselorID: " + counselorParam);
        System.out.println("appointmentID: " + appointmentParam);
        System.out.println("referralTo: " + referralTo);
        System.out.println("reason: " + reason);
        System.out.println("notes: " + notes);

        if (studentParam == null || studentParam.isEmpty() ||
            counselorParam == null || counselorParam.isEmpty() ||
            appointmentParam == null || appointmentParam.isEmpty()) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid ID parameter(s).");
            return;
        }

        int studentID = Integer.parseInt(studentParam);
        int counselorID = Integer.parseInt(counselorParam);
        int appointmentID = Integer.parseInt(appointmentParam);

        try {
            // Load from DAO
            Student student = StudentDAO.getStudentById(studentID);
            Counselor counselor = new CounselorDAO().getCounselorByID(counselorID);
            Appointment appointment = new AppointmentDAO().getAppointmentByID(appointmentID);

            if (student == null || counselor == null || appointment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Data not found.");
                return;
            }

            // Set PDF response headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=referral_letter.pdf");


            ReferralPDFGenerator.generate(
                response.getOutputStream(),
                student,
                counselor,
                appointment,
                referralTo,
                reason,
                notes,
                getServletContext()
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating referral letter.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
