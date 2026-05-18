/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.AssessmentDAO;
import com.DAO.AssessmentResponseDAO;
import com.Model.Assessment;
import com.Model.AssessmentResponse;
import com.Util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class AssessmentResponseServlet extends HttpServlet {
      
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            AssessmentResponseDAO responseDAO = new AssessmentResponseDAO(conn);
            AssessmentDAO assessmentDAO = new AssessmentDAO(conn);
            
            HttpSession session = request.getSession();
            Integer studentID = (Integer) session.getAttribute("studentID");

            if (studentID == null) {
                throw new ServletException("Session expired or student not logged in.");
            }

            // Create an assessment entry first (since we need an assessmentID)
            Assessment assessment = new Assessment();
            assessment.setStudentID(studentID);
            assessment.setDepressionScore(0);
            assessment.setAnxietyScore(0);
            assessment.setStressScore(0);
            assessment.setDepressionResult("");
            assessment.setAnxietyResult("");
            assessment.setStressResult("");
            assessment.setRecommendation("");
            assessment.setStatus("in-progress");

            assessmentDAO.save(assessment);
            int assessmentID = assessment.getAssessmentID();  // Get the generated assessmentID

            // Store responses
            List<AssessmentResponse> responses = new ArrayList<>();
            for (int i = 1; i <= 21; i++) {  // Assuming 21 questions
                int questionID = i;
                int answer = Integer.parseInt(request.getParameter("q" + i));
                AssessmentResponse res = new AssessmentResponse();
                res.setStudentID(studentID);
                res.setAssessmentID(assessmentID);
                res.setQuestionID(questionID);
                res.setResponse(answer);
                responses.add(res);
            }
            
            responseDAO.saveResponses(responses);  // Insert responses into DB

            // Calculate scores
            int depressionScore = 0, anxietyScore = 0, stressScore = 0;
            int[] depressionQ = {3, 5, 10, 13, 16, 17, 21};
            int[] anxietyQ = {2, 4, 7, 9, 15, 19, 20};
            int[] stressQ = {1, 6, 8, 11, 12, 14, 18};

            for (AssessmentResponse res : responses) {
                if (contains(depressionQ, res.getQuestionID())) {
                    depressionScore += res.getResponse();
                } else if (contains(anxietyQ, res.getQuestionID())) {
                    anxietyScore += res.getResponse();
                } else if (contains(stressQ, res.getQuestionID())) {
                    stressScore += res.getResponse();
                }
            }
            
            // Multiply by 2 to match full DASS-42 scale
            depressionScore *= 2;
            anxietyScore *= 2;
            stressScore *= 2;

            // Interpret Scores
            String depressionResult = interpretScore(depressionScore, "depression");
            String anxietyResult = interpretScore(anxietyScore, "anxiety");
            String stressResult = interpretScore(stressScore, "stress");
            String recommendation = "Consider counseling if needed.";

            // Update assessment with calculated scores and results
            assessment.setDepressionScore(depressionScore);
            assessment.setAnxietyScore(anxietyScore);
            assessment.setStressScore(stressScore);
            assessment.setDepressionResult(depressionResult);
            assessment.setAnxietyResult(anxietyResult);
            assessment.setStressResult(stressResult);
            assessment.setRecommendation(recommendation);
            assessment.setStatus("completed");

            assessmentDAO.update(assessment);  // Use update instead of save

            // Pass results to JSP
            request.setAttribute("depressionScore", depressionScore);
            request.setAttribute("anxietyScore", anxietyScore);
            request.setAttribute("stressScore", stressScore);
            request.setAttribute("depressionResult", depressionResult);
            request.setAttribute("anxietyResult", anxietyResult);
            request.setAttribute("stressResult", stressResult);
            request.setAttribute("recommendation", recommendation);

            // Forward the request to the JSP page
            request.getRequestDispatcher("assessment-result.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error while processing assessment responses", e);
        }
    }


    private boolean contains(int[] array, int value) {
        for (int i : array) {
            if (i == value) return true;
        }
        return false;
    }

    private String interpretScore(int score, String type) {
    if (type.equals("depression")) {
        return (score >= 28) ? "Extremely Severe" :
               (score >= 21) ? "Severe" :
               (score >= 14) ? "Moderate" :
               (score >= 10) ? "Mild" : "Normal";
    } else if (type.equals("anxiety")) {
        return (score >= 20) ? "Extremely Severe" :
               (score >= 15) ? "Severe" :
               (score >= 10) ? "Moderate" :
               (score >= 8) ? "Mild" : "Normal";
    } else { // Stress
        return (score >= 34) ? "Extremely Severe" :
               (score >= 26) ? "Severe" :
               (score >= 19) ? "Moderate" :
               (score >= 15) ? "Mild" : "Normal";
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
