<%-- 
    Document   : assessment-counselor
    Created on : 7 Mar 2025, 4:32:06 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"> <!-- Font Awesome -->
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="camstyle.css">
    <title>MINDEASE - Counselor Dashboard</title>
    <style>
        .header {
            text-align: center;
            margin-top: 20px;
            color: #1e1b50;
        }
        
        .content p {
            text-align: center;
            margin-top: 28px;
            font-size: 20px;
            margin-bottom: 15px;
        }
        
        table {
            width: 95%; /* Reduce the width */
            margin: auto; /* Center it */
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 35px;
        }
        
        table, th, td {
            border: 1px solid #ccc;
        }
        
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 17px;
        }
        
        th {
            background-color: #4a3b78;
            color: white;
            text-transform: uppercase;
            width: 20px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        /* Responsive Design */
        @media screen and (max-width: 768px) {
            table {
                width: 95%;
            }

            th, td {
                padding: 8px;
                font-size: 15px;
            }
        }
        
        .fa-calendar-alt, .fa-user-circle {
            color: white;
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
                    <li><a href="QuestionServlet?action=assessmentQ">Assessment Question</a></li>
                    <li><a href="CounselorAppointmentServlet?view=all">Appointment</a></li>
                    <li><a href="FeedbackServlet?action=viewByCounselor">Feedback</a></li>
                </ul>
            </div>
            <div class="navbar-center">
                <h1><a href="CounselorAppointmentServlet" style="text-decoration: none; color: aliceblue;">Counselor Dashboard</a></h1>
            </div>
            <div class="navbar-right">
                <div class="icons">
                    <a href="CounselorAppointmentServlet?view=calendar">
                      <i class="fas fa-calendar-alt"></i>
                    </a>
                    <i class="fas fa-headset"></i> <!-- Headset icon -->
                    <i class="fas fa-bell"></i> <!-- Notification icon -->
                    <a href="CounselorProfile.jsp" title="View Profile">
                        <i class="fas fa-user-circle"></i> <!-- Profile icon -->
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Question list -->
        <div class="header">
            <h1>List of Questions</h1>
        </div>
        <table border="1">
            <thead>
                <tr>
                    <th>Question Text</th>
                    <th>Weight</th>
                    <th>Category</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty questions}">
                <div class="content"><p>Number of questions: ${questions.size()}</p></div>
                    <c:forEach var="questions" items="${questions}">
                        <tr>
                            <td>${questions.questionText}</td>
                            <td>${questions.weight}</td>
                            <td>${questions.category}</td>
                        </tr>
                    </c:forEach>
                </c:if>

                <c:if test="${empty questions}">
                    <tr>
                        <td colspan="5">No questions found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
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
        
    </body>
</html>
