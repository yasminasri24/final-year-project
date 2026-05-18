<%-- 
    Document   : view-assessment
    Created on : 23 Jun 2025, 11:27:26 pm
    Author     : DELL
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="camstyle.css">
        <title>View Assessment - Counselor</title>
        <style>
        .container {
            background: white;
            padding: 30px;
            max-width: 800px;
            margin: 30px auto;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        
        .container h2 { 
            color: #333; 
            margin-bottom: 20px;
        }
        
        .result {
            padding: 10px 0;
            font-size: 17px;
            margin-bottom: 10px;
        }
        
        .label { 
            font-weight: bold; 
        }
        
        .fa-calendar-alt, .fa-user-circle {
            color: white;
        }
        
        .btn-appt {
            background-color: #007bff;
            color: white;
            padding: 10px 12px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }
        
        .btn-appt:hover {
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
         
        <div class="container">
            <h2>Latest DASS-21 Assessment</h2>

            <c:if test="${not empty assessment}">
                <div class="result"><span class="label">Date:</span>
                    <fmt:formatDate value="${assessment.date}" pattern="dd-MM-yyyy" />
                </div>
                <div class="result"><span class="label">Depression Score:</span> ${assessment.depressionScore} (${assessment.depressionResult})</div>
                <div class="result"><span class="label">Anxiety Score:</span> ${assessment.anxietyScore} (${assessment.anxietyResult})</div>
                <div class="result"><span class="label">Stress Score:</span> ${assessment.stressScore} (${assessment.stressResult})</div>
                <div class="result"><span class="label">Recommendation:</span> ${assessment.recommendation}</div>
            </c:if>

            <c:if test="${empty assessment}">
                <p>No assessment found for this student.</p>
            </c:if>

            <br>
            <a href="CounselorAppointmentServlet?view=all" class="btn-appt">Back to Appointments</a>
        </div>
         
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
