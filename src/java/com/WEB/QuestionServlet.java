/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.QuestionDAO;
import com.Model.Question;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author DELL
 */
public class QuestionServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private QuestionDAO questionDAO;
    
    @Override
    public void init() throws ServletException {
        questionDAO = new QuestionDAO();
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {     
            case "list":
                listQuestions(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteQuestion(request, response);
                break;
            case "assessmentQ":
                listAssessmentQ(request, response);
                break;
            default:
                listQuestions(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addQuestion(request, response);
                break;
            case "update":
                updateQuestion(request, response);
                break;
            default:
                listQuestions(request, response);
                break;
        }
    }
    
    //Display All Questions
    private void listQuestions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Question> questions = questionDAO.getAllQuestions();
        if (questions == null || questions.isEmpty()) {
            request.setAttribute("questions", new ArrayList<>()); // Avoid null issues
        } else {
            request.setAttribute("questions", questions);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("question-staff.jsp");
        dispatcher.forward(request, response);
    }
    
    //Display All Questions for Counselor
    private void listAssessmentQ(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Question> questions = questionDAO.getAllQuestions();
        request.setAttribute("questions", questions != null ? questions : new ArrayList<>()); 
        RequestDispatcher dispatcher = request.getRequestDispatcher("assessment-counselor.jsp");
        dispatcher.forward(request, response);
    }
    
    //Add question
    private void addQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String questionText = request.getParameter("questionText");
            int weight = Integer.parseInt(request.getParameter("weight"));
            String category = request.getParameter("category");

            boolean added = questionDAO.addQuestion(questionText, weight, category);

            if (added) {
                request.getSession().setAttribute("message", "Question added successfully!");
            } else {
                request.getSession().setAttribute("error", "Failed to add question. Try again.");
            }

            response.sendRedirect("QuestionServlet?action=list");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid input format!");
            response.sendRedirect("QuestionServlet?action=list");
        }
    }

    //Show Edit Form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int questionID = Integer.parseInt(request.getParameter("questionID"));
            Question question = questionDAO.getQuestionByID(questionID);
            if (question != null) {
                request.setAttribute("question", question);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editQuestion-staff.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("QuestionServlet?action=list&error=Question not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("QuestionServlet?action=list&error=Invalid question ID");
        }
    }
    
    //Update Question
    private void updateQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int questionID = Integer.parseInt(request.getParameter("questionID"));
            String questionText = request.getParameter("questionText");
            int weight = Integer.parseInt(request.getParameter("weight"));
            String category = request.getParameter("category");

            boolean updated = questionDAO.updateQuestion(questionID, questionText, weight, category);

            if (updated) {
                request.getSession().setAttribute("message", "Question updated successfully!");
                response.sendRedirect("QuestionServlet?action=list");
            } else {
                request.getSession().setAttribute("error", "Update failed. Please try again.");
                response.sendRedirect("editQuestion-staff.jsp?questionID=" + questionID);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid question ID format!");
            response.sendRedirect("QuestionServlet?action=list");
        }
    }

    //Delete Question
    private void deleteQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int questionID = Integer.parseInt(request.getParameter("questionID"));

            boolean deleted = questionDAO.deleteQuestion(questionID);

            if (deleted) {
                request.getSession().setAttribute("message", "Question deleted successfully!");
                response.sendRedirect("QuestionServlet?action=list");
            } else {
                request.getSession().setAttribute("message", "Delete failed!");
                response.sendRedirect("QuestionServlet?action=list");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("QuestionServlet?action=list&error=Invalid question ID");
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
