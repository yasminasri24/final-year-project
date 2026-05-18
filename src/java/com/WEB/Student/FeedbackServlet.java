/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Student;

import com.DAO.FeedbackDAO;
import com.Model.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
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
public class FeedbackServlet extends HttpServlet {
    
    private FeedbackDAO dao = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("edit".equals(action)) {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            int studentID = Integer.parseInt(request.getParameter("studentID"));

            Feedback feedback = dao.getFeedbackByAppointmentID(appointmentID);
            request.setAttribute("feedback", feedback);
            request.setAttribute("appointmentID", appointmentID);
            request.setAttribute("studentID", studentID);
            request.getRequestDispatcher("submitFeedback.jsp").forward(request, response);
            return;
        }

        else if ("viewByCounselor".equals(action)) {
            int counselorID = (int) session.getAttribute("counselorID");
            List<Feedback> feedbackList = dao.getFeedbackByCounselor(counselorID);
            request.setAttribute("feedbackList", feedbackList);
            request.getRequestDispatcher("viewFeedback-counselor.jsp").forward(request, response);
            return;
        }

        else if ("viewAll".equals(action)) {
            String search = request.getParameter("search");
            List<Feedback> feedbackList = dao.getAllFeedback(search);
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("search", search);
            request.getRequestDispatcher("viewFeedback-admin.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        int studentID = Integer.parseInt(request.getParameter("studentID"));

        try {
            if ("add".equals(action) || "edit".equals(action)) {
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comments = request.getParameter("comments");

                Feedback fb = new Feedback();
                fb.setAppointmentID(appointmentID);
                fb.setStudentID(studentID);
                fb.setRating(rating);
                fb.setComments(comments);

                if ("add".equals(action)) {
                    dao.insertFeedback(fb);
                    request.setAttribute("message", "⭐ Feedback submitted successfully!");
                } else {
                    dao.updateFeedback(fb);
                    request.setAttribute("message", "✏️ Feedback updated successfully!");
                }
            } else if ("delete".equals(action)) {
                dao.deleteFeedback(appointmentID, studentID);
                request.setAttribute("message", "🗑️ Feedback deleted successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Failed to process feedback. Please try again.");
        }

        request.setAttribute("appointmentID", appointmentID);
        request.setAttribute("studentID", studentID);
        request.getRequestDispatcher("submitFeedback.jsp").forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
