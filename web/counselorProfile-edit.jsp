<%-- 
    Document   : manageProfile
    Created on : 16 Jan 2025, 3:57:45 am
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
    <title>MINDEASE - Manage Counselor Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
            height: auto;
        }
        
        .container {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            min-height: 55vh; /* Full height */
            flex-direction: column;
            margin-bottom: 30px;
        }

        h1 {
            color: #1e1b50;
            margin-top: 20px;
        }
        
        .signup-container {
            justify-content: flex-start;
            display: flex;
            width: 380px;
            padding: 22px;
            background-color: #505081;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            margin-top: 1%;
            flex: 1;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: flex;
            margin-bottom: 10px;
            font-size: 15px;
            color: white;
        }

        .form-group input, .form-group select {
            width: 140%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            box-shadow: 0 0 5px #5a5ae6;
        }
        
        .input-group {
            display: flex;
            align-items: center;
            background-color: #eee;
            border-radius: 5px;
            padding: 5px;
            margin-bottom: 15px;
        }

        .input-group .icon {
            margin: 0 10px;
            color: gray;
        }

        .input-group input {
            flex: 1;
            border: none;
            background: none;
            padding: 10px;
            font-size: 14px;
            outline: none;
        }

        .signup-container p {
            font-size: 15px;
            text-align: center;
            color: #ccc;
        }

        /* Button styling */
        .form-buttons {
            text-align: center;
            margin-top: 15px;
            margin-left: 80px;
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
        
        <h1>Manage Profile - Counselor</h1>
        <% 
            Counselor counselor = (Counselor) request.getAttribute("counselor"); 
            if (counselor == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="container">
            <div class="signup-container">
                <form action="CounselorServlet" method="post">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" name="username" id="username" value="<%= counselor.getUsername() %>" required>
                    </div> 

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" placeholder="Enter new password (leave blank to keep current)">
                    </div> 

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= counselor.getEmail() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="counselorname">Counselor Name:</label>
                        <input type="text" id="counselorname" name="counselorname" value="<%= counselor.getCounselorname() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="specialization">Specialization:</label>
                        <input type="text" id="specialization" name="specialization" value="<%= counselor.getSpecialization() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneC">Number Phone:</label>
                        <input type="text" id="phoneC" name="phoneC" value="<%= counselor.getPhoneC() %>" required>
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
            window.location.href = "CounselorProfile.jsp"; // Change this to your actual profile page URL
        }
    </script>
    
    </body>
</html>
