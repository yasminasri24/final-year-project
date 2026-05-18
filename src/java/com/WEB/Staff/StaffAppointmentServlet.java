/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Staff;

import com.DAO.AppointmentDAO;
import com.Model.Appointment;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class StaffAppointmentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        AppointmentDAO dao = new AppointmentDAO();

        try {
            switch (action) {
                case "adminList":
                    String status = request.getParameter("status");
                    List<Appointment> appointments;

                    if (status != null && !status.isEmpty()) {
                        appointments = dao.getAppointmentsByStatus(status);
                        request.setAttribute("selectedStatus", status); // For keeping dropdown selection
                    } else {
                        appointments = dao.getAllAppointments();
                    }

                    request.setAttribute("appointments", appointments);
                    request.getRequestDispatcher("appointment-staff.jsp").forward(request, response);
                    break;
                case "edit":
                    int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
                    Appointment appointment = dao.getAppointmentByID(appointmentID);
                    request.setAttribute("appointment", appointment);
                    request.getRequestDispatcher("edit-appointmentStaff.jsp").forward(request, response);
                    break;
                case "delete":
                    appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
                    boolean success = dao.deleteAppointment(appointmentID, getServletContext());

                    if (success) {
                        request.getSession().setAttribute("message", "Appointment deleted successfully!");
                    } else {
                        request.getSession().setAttribute("message", "Delete failed!");
                    }

                    response.sendRedirect("StaffAppointmentServlet?action=adminList");
                    break;
                default:
                    response.sendRedirect("appointment-staff.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
