<%-- 
    Document   : manageProfile
    Created on : 16 Jan 2025, 3:57:45 am
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
        response.sendRedirect("login.jsp");
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
    <title>MINDEASE - Manage Student Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        
        h1 {
            color: #1e1b50;
            margin-top: 20px;
        }
        
        .container {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            min-height: 55vh; /* Full height */
            color: aliceblue;
        }
        
        .profile-container {
            width: 35%;
            padding: 22px;
            background-color: #505081;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        
        /* Form container - creates two columns */
        .form-container {
            display: flex;
            justify-content: space-between;
            gap: 20px; /* Space between columns */
            max-width: 700px;
            margin: auto;
        }

        /* Left & Right column styles */
        .form-left, .form-right {
            width: 48%;
            display: flex;
            flex-direction: column;
        }
        
        label {
            text-align: justify;
            margin-bottom: 10px;
        }

        /* Input fields styling */
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }

        /* Button styling */
        .form-buttons {
            text-align: center;
            margin-top: 15px;
        }

        .save-btn, .cancel-btn {
            padding: 10px 15px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .save-btn {
            background-color: #007bff;
            color: white;
            margin-right: 10px;
        }

        .cancel-btn {
            background-color: #dc3545;
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                flex-direction: column;
            }

            .form-left, .form-right {
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
        
        <h1>Manage Profile - Student</h1>
        
        <% 
            Student student = (Student) request.getAttribute("student"); 
            if (student == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        
        <div class="container">
            <div class="profile-container">
                <form action="StudentServlet" method="post" class="edit-profile-form">
                    <div class="form-container">
                        <!-- Left Column -->
                        <div class="form-left">
                            <label for="username">Username:</label>
                            <input type="text" name="username" id="username" value="<%= student.getUsername() %>" required>

                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" placeholder="Enter new password (leave blank to keep current)">

                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="<%= student.getEmail() %>" required>

                            <label for="studentname">Student Name:</label>
                            <input type="text" id="studentname" name="studentname" value="<%= student.getStudentName() %>" required>
                        </div>

                        <!-- Right Column -->
                        <div class="form-right">
                            <label>Program:</label>
                            <input type="text" name="program" value="${student.program}" required/><br>

                            <label>Year:</label>
                            <input type="number" name="year" value="${student.year}" required/><br>

                            <label>Gender:</label>
                            <input type="text" name="gender" value="${student.gender}" required/><br>

                            <label>Number Phone:</label>
                            <input type="text" name="phoneS" value="${student.phoneS}" required/><br>
                        </div>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="save-btn">Save</button>
                        <button type="button" class="cancel-btn" onclick="goBack()">Cancel</button>
                    </div>
                </form>
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
    
    <script>
        function goBack() {
            window.location.href = "StudentProfile.jsp"; // Change this to your actual profile page URL
        }
    </script>
    
    </body>
</html>
