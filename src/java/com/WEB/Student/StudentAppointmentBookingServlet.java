/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Student;

import com.DAO.AppointmentDAO;
import com.DAO.UserDAO;
import com.Model.Appointment;
import com.Model.Counselor;
import com.Model.Student;
import com.Util.EmailUtil;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

public class StudentAppointmentBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        AppointmentDAO dao = new AppointmentDAO();

        if ("history".equals(action)) {
            session = request.getSession();
            Integer studentID = (Integer) session.getAttribute("studentID");

            if (studentID != null) {
                dao = new AppointmentDAO();
                List<Appointment> appointments = dao.getAppointmentsByStudent(studentID);

                request.setAttribute("appointments", appointments);
                RequestDispatcher dispatcher = request.getRequestDispatcher("history-student.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
            
        } else if ("loadDashboard".equals(action)) {
            int studentID = (int) session.getAttribute("studentID"); // adjust based on your session key
            Appointment upcoming = dao.getUpcomingAppointment(studentID);
            if (upcoming != null && upcoming.getDate() != null) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MM-dd-yyyy");
                String formattedDate = sdf.format(upcoming.getDate());
                request.setAttribute("formattedDate", formattedDate);
            }

            if (upcoming != null) {
                System.out.println("Debug: Successfully retrieved upcoming appointment - ID: " + upcoming.getAppointmentID());
            } else {
                System.out.println("Debug: upcomingAppointment is NULL after retrieval.");
            }

            request.setAttribute("upcomingAppointment", upcoming);
            request.getRequestDispatcher("studentDashboard.jsp").forward(request, response);
            
        } else if ("editForm".equals(action)) {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            dao = new AppointmentDAO(); // or inject if you're using DI
            Appointment appointment = dao.getAppointmentByID(appointmentID);
            List<Time> availableSlots = new ArrayList<>();
            try {
                availableSlots = dao.getAvailableTimeSlots(appointment.getDate());
            } catch (SQLException ex) {
                Logger.getLogger(StudentAppointmentBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("appointment", appointment);
            request.setAttribute("availableSlots", availableSlots);
            request.getRequestDispatcher("editAppt-student.jsp").forward(request, response);

        } else {
            // Handle other GET actions here
        }
             
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        AppointmentDAO dao = new AppointmentDAO();
        UserDAO userDAO = new UserDAO();

        try {
            Integer studentID = (Integer) session.getAttribute("studentID");
            if (studentID == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            switch (action) {
                case "book":
                    // Ensure session attribute studentID exists
                    studentID = (Integer) session.getAttribute("studentID");
                    if (studentID == null) {
                        request.setAttribute("error", "Session expired. Please log in again.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        return;
                    }

                    String typeCounseling = request.getParameter("typeCounseling");
                    String category = request.getParameter("category");
                    String groupMembers = request.getParameter("groupMembers");
                    Date date = Date.valueOf(request.getParameter("date"));
                    Time time = Time.valueOf(request.getParameter("time") + ":00");

                    int counselorID;
                    Counselor counselor;

                    try {
                        counselor = dao.autoAssignCounselor(date, time);
                        if (counselor == null) {
                            // Handle the error (e.g., show an error message or redirect)
                            throw new Exception("No available counselor found.");
                        }
                        counselorID = counselor.getCounselorID();
                    } catch (SQLException e) {
                        // Counselor not available at selected time
                        request.setAttribute("errorMessage", "No counselor is available at the selected time. Please choose a different time.");

                        // Suggest other available times
                        List<Time> availableSlots = dao.getAvailableTimeSlots(date);
                        request.setAttribute("availableSlots", availableSlots);

                        request.getRequestDispatcher("appointment-student.jsp").forward(request, response);
                        return;
                    }

                    Student student = dao.getStudentDetails(studentID);

                    String studentEmail = userDAO.getUserEmailByStudentID(studentID);
                    String counselorEmail = userDAO.getUserEmailByCounselorID(counselorID);

                    Appointment appointment = new Appointment();
                    appointment.setStudentID(studentID);
                    appointment.setCounselorID(counselorID);
                    appointment.setDate(date);
                    appointment.setTime(time);
                    appointment.setCategory(category);
                    appointment.setTypeCounseling(typeCounseling);
                    appointment.setGroupMembers(groupMembers == null ? "" : groupMembers);
                    appointment.setStatus("Pending");
                    appointment.setStudentEmail(studentEmail);
                    appointment.setCounselorEmail(counselorEmail);

                    dao.insertAppointment(appointment, getServletContext());

                    // Format the date as MM-dd-yyyy
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    String formattedDate = sdf.format(date);

                    // Send emails
                    String studentMsg = "Hi, your counseling appointment has been scheduled.\n\n"
                            + "Date: " + formattedDate + "\nTime: " + time + "\nCategory: " + category + "\nType: " + typeCounseling
                            + "\n\nCounselor: " + counselor.getCounselorname() + "\nContact: " + counselor.getPhoneC() + 
                            "\n\nPlease contact your counselor if you have any question regarding to your appointment session. "
                            + "Thank you for using MINDEASE!";
                    EmailUtil.sendEmail(studentEmail, "Counseling Appointment Confirmation", studentMsg);

                    String counselorMsg = "You have been assigned a new counseling appointment.\n\n"
                            + "Student Name: " + student.getStudentName() + "\nStudent Phone: " + student.getPhoneS()
                            + "\nDate: " + formattedDate + "\nTime: " + time + "\nCategory: " + category
                            + "\nType: " + typeCounseling + "\n\nPlease check the CAMS system for more details.";
                    EmailUtil.sendEmail(counselorEmail, "New Counseling Appointment Assigned", counselorMsg);

                    request.setAttribute("appointment", appointment);
                    request.setAttribute("counselor", counselor);
                    request.getRequestDispatcher("appointment-confirmationStudent.jsp").forward(request, response);

                    break;
                    
                case "update":
                    int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
                    String type = request.getParameter("typeCounseling");
                    category = request.getParameter("category");
                    groupMembers = request.getParameter("groupMembers");
                    date = Date.valueOf(request.getParameter("date"));
                    String timeStr = request.getParameter("time");
                    if (timeStr.length() == 5) {
                        timeStr += ":00";
                    }
                    time = Time.valueOf(timeStr);

                    Appointment current = dao.getAppointmentByID(appointmentID); // fetch existing

                    Appointment updated = new Appointment();
                    updated.setAppointmentID(appointmentID);
                    updated.setTypeCounseling(type);
                    updated.setCategory(category);
                    updated.setGroupMembers(groupMembers);
                    updated.setDate(date);
                    updated.setTime(time);
                    updated.setEventID(current.getEventID());
                    updated.setStudentID(current.getStudentID());
                    updated.setCounselorID(current.getCounselorID());

                    dao.updateAppointment(updated, getServletContext());

                    response.sendRedirect("StudentAppointmentBookingServlet?action=loadDashboard&updateSuccess=true");
                    break;
                    
                case "delete":
                    appointmentID = Integer.parseInt(request.getParameter("appointmentID"));

                    boolean deleted = dao.deleteAppointment(appointmentID, getServletContext());

                    if (deleted) {
                        request.getSession().setAttribute("successMessage", "Appointment cancelled successfully.");
                        response.sendRedirect("StudentAppointmentBookingServlet?action=loadDashboard");
                    } else {
                        request.setAttribute("error", "Failed to delete appointment.");
                        response.sendRedirect("StudentAppointmentBookingServlet?action=loadDashboard");
                    }
                    break;
    
                case "history":
                    List<Appointment> history = dao.getAppointmentsByStudent(studentID);
                    request.setAttribute("appointments", history);
                    request.getRequestDispatcher("history-student.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("StudentAppointmentBookingServlet?action=loadDashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
