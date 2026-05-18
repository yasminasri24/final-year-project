<%-- 
    Document   : assessment-question
    Created on : 17 Jan 2025, 6:19:56 pm
    Author     : DELL
--%>

<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.Model.Question" %>
<%@ page import="com.DAO.QuestionDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
    // Ensure the session is active and retrieve the assessment ID
    Integer assessmentID = (Integer) session.getAttribute("assessmentID");

    if (assessmentID == null) {
        assessmentID = 1; // Default value (you can change this based on logic)
    }

    QuestionDAO questionDAO = new QuestionDAO();
    List<Question> questions = null;

    try {
        questions = questionDAO.getAllQuestions();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
         <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"> <!-- Font Awesome -->
        <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="camstyle.css">
        <title>MINDEASE - Student Dashboard</title>
        <style>
            .assessment-container h2 {
                text-align: center;
                color: #1e1b50;
                margin: 25px;
                font-size: 28px;
            }
            
            .fa-user-circle {
                color: white;
            }

            /* Table Styling */
            table {
                width: 80%; /* Reduce the width */
                margin: auto; /* Center it */
                border-collapse: collapse;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            table th, table td {
                border: 1px solid #ccc;
                padding: 12px;
                text-align: center;
                font-size: 17px;
            }

            table th {
                background-color: #4a3b78;
                color: white;
                text-transform: uppercase;
            }

            /* Submit Button */
            .submit-btn {
                display: block;
                width: 8%;
                padding: 10px;
                background-color: #4a3b78;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 10px;
                font-size: 17px;
                margin-top: 15px;
                margin-bottom: 20px;
                margin-inline: auto;
            }

            .submit-btn:hover {
                background-color: #0056b3;
            }
        </style>     
    </head>
    <body>
     <!-- Navigation Bar -->
    <div class="navbar">
        <div class="navbar-left">
            <div class="logo">
                <h2>MINDEASE<i class="material-icons logo-icon">handshake</i></h2>
            </div>
            <ul class="nav-links">
                <li><a href="assessment-student.jsp">Assessment</a></li>
                <li><a href="appointment-student.jsp">Appointment</a></li>
                <li><a href="StudentAppointmentBookingServlet?action=history">History</a></li>
            </ul>
        </div>
        <div class="navbar-center">
            <h1><a href="StudentAppointmentBookingServlet?action=loadDashboard" style="text-decoration: none; color: aliceblue;">Student Dashboard</a></h1>
        </div>
        <div class="navbar-right">
            <div class="icons">
                <i class="fas fa-headset"></i> <!-- Headset icon -->
                <i class="fas fa-bell"></i> <!-- Notification icon -->
                <a href="StudentProfile.jsp" title="View Profile">
                    <i class="fas fa-user-circle"></i> <!-- Profile icon -->
                </a>
            </div>
        </div>
    </div>
    
    <main>
        <section class="assessment-container">
            <h2>DASS-21 Assessment</h2>
            <form action="AssessmentResponseServlet" method="post">
                <input type="hidden" name="assessmentID" value="<%= assessmentID %>">
                <table border="1">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Question</th>
                            <th>Never (0)</th>
                            <th>Sometimes (1)</th>
                            <th>Often (2)</th>
                            <th>Almost Always (3)</th>
                        </tr>
                    </thead>

                    <%
                        if (questions != null && !questions.isEmpty()) {
                            int count = 1;
                            for (Question q : questions) {
                    %>
                    
                    <tbody>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= q.getQuestionText() %></td>
                            <td><input type="radio" name="q<%= q.getQuestionID() %>" value="0" required></td>
                            <td><input type="radio" name="q<%= q.getQuestionID() %>" value="1"></td>
                            <td><input type="radio" name="q<%= q.getQuestionID() %>" value="2"></td>
                            <td><input type="radio" name="q<%= q.getQuestionID() %>" value="3"></td>
                        </tr>
                            <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="6">No questions available. Please check your database.</td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <br>
                <button type="submit" class="submit-btn">Submit</button>
            </form>
        </section> 
    </main>
    
    <footer class="footer">
        <div class="footer-container">
            <!-- About Section -->
            <div class="footer-section">
                <h3>About Us</h3>
                <p>MindEase is here to provide mental health support and resources to students.</p>
            </div>

            <!-- Quick Links Section -->
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Help Center</a></li>
                </ul>
            </div>

            <!-- Contact Section -->
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: <a href="mailto:support@mindease.com">support@mindease.com</a></p>
                <p>Phone: +012345678943</p>
            </div>

            <!-- Social Media Links -->
            <div class="footer-section">
                <h3>Follow Us</h3>
                <i class="fa-brands fa-facebook"></i>
                <i class="fa-brands fa-twitter"></i>
                <i class="fa-brands fa-instagram"></i>
            </div>
        </div>
        <hr class="footer-divider">
        <p class="footer-bottom">© 2025 MindEase. All rights reserved.</p>
    </footer>
    
    <script>
        // Function to update the progress bar based on the number of questions answered
        function updateProgressBar() {
          const totalQuestions = document.querySelectorAll('.questions-table tr').length; // Count the total number of questions
          const answeredQuestions = document.querySelectorAll('.questions-table input[type="radio"]:checked').length; // Count answered questions
          const progress = (answeredQuestions / totalQuestions) * 100; // Calculate progress percentage

          const progressBar = document.querySelector('.progress');
          progressBar.style.width = progress + '%'; // Update the progress bar width
        }

        // Attach event listeners to all radio buttons to trigger progress bar update
        document.querySelectorAll('.questions-table input[type="radio"]').forEach((radioButton) => {
          radioButton.addEventListener('change', updateProgressBar);
        });

        // Initialize progress bar on page load
        window.addEventListener('load', updateProgressBar);
    </script>
    </body>
</html>
