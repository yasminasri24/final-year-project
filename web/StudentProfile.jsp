<%-- 
    Document   : StudentProfile
    Created on : 4 Mar 2025, 4:55:12 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.Model.Student" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userID") == null) {
        response.sendRedirect("StudentServlet?action=profile");
        return;
    }

    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        response.sendRedirect("StudentServlet?action=profile");
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
    <title>MINDEASE - Student Profile</title>
    <style>
        .fa-user-circle {
            color: white;
        }

        .profile {
            color: #1e1b50;
            font-size: 35px;
            text-align: center;
            font-weight: bold;
            font-family: sans-serif;
            margin-top: 20px;
        }

        /* Profile title styling */
        .profile h1 {
            font-size: 40px;
            font-weight: bold;
            color: #1e1b50; /* Dark blue color */
        }

        .profile-container {
            width: 45%;
            margin: auto;
            background: linear-gradient(135deg, #3f3d56, #59577c); /* Gradient background */
            padding: 25px;
            border-radius: 15px;
            color: white;
            text-align: center;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }

        .title {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .profile-content {
            display: flex;
            justify-content: flex-end;
            text-align: left;
            padding: 10px 20px;
        }

        .profile-left, .profile-right {
            width: 48%;
        }

        p {
            margin: 8px 0;
            margin-bottom: 15px;
            font-size: 17px;
        }

        .buttons {
            margin-top: 15px;
        }

        .update-btn, .logout-btn {
            padding: 8px 18px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .update-btn {
            background-color: #007bff;
            color: white;
            margin-right: 8px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
        }
        
        /* Make it responsive */
        @media (max-width: 768px) {
            .profile-container {
                width: 80%; /* Adjust width for smaller screens */
            }

            .profile-content {
                flex-direction: column;
                text-align: center;
            }

            .profile-left, .profile-right {
                width: 100%;
            }
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
        
        <div class="profile">
            <h1>Profile <%= student.getUsername() %></h1>
        </div>

        <div class="profile-container">
            <div class="profile-content">
                <div class="profile-left">
                    <p><strong>Username:</strong> <%= student.getUsername() %></p>
                    <p><strong>Email:</strong> <%= student.getEmail() %></p>
                    <p><strong>Student Name:</strong> <%= student.getStudentName() %></p>
                    <p><strong>Program:</strong> <%= student.getProgram() %></p>
                </div>
                <div class="profile-right">
                    <p><strong>Year:</strong> <%= student.getYear() %></p></p>
                    <p><strong>Gender:</strong> <%= student.getGender() %></p></p>
                    <p><strong>Number Phone:</strong> <%= student.getPhoneS() %></p></p>
                </div>
            </div>
            <div class="buttons">
                <a href="StudentServlet?action=editProfile" class="update-btn">Update</a>
                <a href="LogoutServlet" class="logout-btn">Logout</a>
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
