<%-- 
    Document   : CounselorProfile
    Created on : 5 Mar 2025, 12:44:12 am
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.Model.Counselor" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userID") == null) {
        response.sendRedirect("CounselorServlet?action=profile");
        return;
    }

    Counselor counselor = (Counselor) request.getAttribute("counselor");
    if (counselor == null) {
        response.sendRedirect("CounselorServlet?action=profile");
        return;
    }
%>
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
    <title>MINDEASE - Counselor Profile</title>
    <style>
        /* Center the profile section */
        .profile-container {
            text-align: center;
        }

        /* Profile title styling */
        .profile-container h1 {
            font-size: 40px;
            font-weight: bold;
            color: #1e1b50; /* Dark blue color */
            margin-bottom: 2%; /* Space between title and details box */
        }

        /* Center the details container */
        .container {
            width: 25%; /* Adjust width */
            margin: 0 auto; /* Center horizontally */
            background: linear-gradient(135deg, #3f3d56, #59577c); /* Gradient background */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            color: white;
        }

        /* Information styling */
        .info-container {
            display: flex;
            flex-direction: column;
            gap: 30px; /* Spacing between info lines */
            justify-content: space-evenly;
            align-items: anchor-center;
        }

        .info {
            font-size: 18px;
            display: flex;
            justify-content: space-between; /* Justify content */
            padding: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .info:last-child {
            border-bottom: none;
        }

        .info span {
            font-weight: bold;
            color: #f8f9fa;
        }

        /* Buttons */
        .buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 7%;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-update {
            background-color: #007bff;
            color: white;
        }

        .btn-logout {
            background-color: #dc3545;
            color: white;
        }

        .btn-update:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .btn-logout:hover {
            background-color: #a71d2a;
            transform: scale(1.05);
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
        
        <div class="profile-container">
            <!-- Centered Profile Header -->
            <h1>Profile <%= counselor.getUsername() %></h1>

            <!-- Profile Container -->
            <div class="container">
                <div class="info-container">
                    <div class="info"><span>Username:</span> <%= counselor.getUsername() %></div>
                    <div class="info"><span>Email:</span> <%= counselor.getEmail() %></div>
                    <div class="info"><span>Counselor Name:</span> <%= counselor.getCounselorname() %></div>
                    <div class="info"><span>Specialization:</span> <%= counselor.getSpecialization() %></div>
                    <div class="info"><span>Number Phone:</span> <%= counselor.getPhoneC() %></div>
                </div>
                <div class="buttons">
                    <a href="CounselorServlet?action=editProfile" class="btn btn-update">Update</a>
                    <a href="LogoutServlet" class="btn btn-logout">Logout</a>
                </div>
            </div>
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
                
    <script type="text/javascript">
        // Retrieve session message and show alert if not empty
        <c:if test="${not empty sessionScope.message}">
            alert("${sessionScope.message}");
        </c:if>
    </script>

    <%-- Clear the session message so it doesn't appear again --%>
    <%
        session.removeAttribute("message");
    %>
    
    </body>
</html>
