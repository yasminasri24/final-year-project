<%-- 
    Document   : assessment-student
    Created on : 17 Jan 2025, 3:57:08 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="camstyle.css">
    <title>MINDEASE - Student Dashboard</title>
    <style>
        /* Main Content */
        .assessment-container {
          text-align: center;
          background-color: #505081;
          color: white;
          padding: 40px 35px;
          margin: 25px auto;
          max-width: 810px;
          border-radius: 20px;
        }
        
        .header {
            margin-top: 15px;
        }

        .header h1 {
            color: #1e1b50;
            font-size: 35px;
            text-align: center;
            font-weight: bold;
            font-family: sans-serif;
            margin-top: 12px;
        }

        .assessment-container h2 {
          margin-bottom: 30px;
          font-size: 30px;
          font-weight: bold;
          color: white;
        }

        .assessment-container p {
          margin-bottom: 15px;
          font-size: 18px;
          color: white;
          line-height: 1.5;
        }
        
        .fa-user-circle {
            color: white;
        }


        /* Button Container */
        .button-container {
          display: flex;
          justify-content: center;
          align-items: center;
          margin-top: 10px;
          margin-bottom: 15px;
        }

        /* Button */
        .start-button {
          background-color: #272757;
          color: white;
          font-size: 18px;
          border: none;
          padding: 12px 20px;
          border-radius: 50px;
          cursor: pointer;
          width: 8%;
        }

        .start-button:hover {
          background-color: #433a68;
        }
        
        .button-container a {
            text-decoration: none;
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
    
    <div class="header">
        <h1>Welcome to the Mental Health Assessment</h1>
    </div>
    <div class="assessment-container">       
        <h2>Depression, Anxiety, Stress Scale (DASS)</h2>
        <p>
          The purpose of this assessment is to help you comprehend how you are feeling right now. 
          The DASS is a scientifically proven instrument that assesses your potential levels of depression, anxiety, and stress.
        </p>
        <p>
          Your answers will be kept private and utilized just to offer tailored suggestions for counseling assistance. 
          Kindly provide honest answers to each question based on your feelings during the past week.
        </p>
        <p>
          You’ll receive your results and useful advice on what to do next after completing the assessment.
        </p>
        <p>Take your time, and when you’re ready, start the assessment!</p>
    </div>
    <div class="button-container">
        <button class="start-button"><a href="assessment-question.jsp">Start</a>
        </button>
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
