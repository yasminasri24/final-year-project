<%-- 
    Document   : appointment-confirmationStudent
    Created on : 5 May 2025, 2:12:34 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.Model.Counselor, com.Model.Appointment" %>
<%
    Appointment appointment = (Appointment) request.getAttribute("appointment");
    Counselor counselor = (Counselor) request.getAttribute("counselor");
    
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
        <title>MINDEASE - Appointment Confirmation (Student)</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                height: 100vh;
            }
            
            .fa-user-circle {
                color: white;
            }
            
            .appt-result {
                text-align: center;
            }
            
            .appt-result h1 {
                font-size: 28px;
                margin-bottom: 30px;
                color: green;
            }
            
            .appt-container {
                width: 50%;
                margin: -36px auto 20px auto; /* Reduce top margin */
                background-color: darkslateblue;
                padding: 25px;
                border-radius: 15px;
                color: white;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }
            
            .appt-content {
                display: flex;
                justify-content: flex-end;
                text-align: left;
                padding: 10px 20px;
            }
            
            .details-left, .details-right {
                width: 60%;
            }
            
            .appt-content p {
                margin: 8px 0;
                margin-bottom: 15px;
                font-size: 17px;
            }
            
            .appt-details {
                background-color: #505081;
                border-radius: 12px;
                padding: 22px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                width: 100%;
                display: inline-block;
                text-align: -webkit-auto;
                color: aliceblue;
                font-size: 17px;
            }
            
            .appt-details h2 {
                margin-bottom: 15px;
            }
             
            .appt-details p {
                font-size: 16px;
                margin-bottom: 15px;
            }
            
            .button {
                margin-top: 20px;
                display: block;
                text-align: center;
            }
 
            .list, .dashboard {
                padding: 10px 18px;
                font-size: 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                background-color: #272757;
                color: white;
                margin-right: 10px;
            }
            
            /* Make it responsive */
            @media (max-width: 768px) {
                .appt-content {
                    flex-direction: column;
                    text-align: center;
                }

                .details-left, .details-right {
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
        
        <div class="appt-result">
            <h1>Appointment Booked Successfully!</h1>
        </div>
        
        <div class="appt-container">
            <div class="appt-details">
                <div class="appt-content">
                    <div class="details-left">
                        <h2>Appointment Details:</h2>
                        <p><strong>Date:</strong> 
                            <fmt:formatDate value="${appointment.date}" pattern="dd-MM-yyyy" />
                         </p>
                        <p><strong>Time:</strong> <%= appointment.getTime() %></p>
                        <p><strong>Type of Counseling:</strong> <%= appointment.getTypeCounseling() %></p>
                        <p><strong>Category:</strong> <%= appointment.getCategory() %></p>

                        <% if ("Group".equalsIgnoreCase(appointment.getTypeCounseling())) { %>
                            <p><strong>Group Participants:</strong> <%= appointment.getGroupMembers() %></p>
                        <% } %>
                    </div>

                    <div class="details-right">
                        <h2>Counselor Details:</h2>
                        <p><strong>Name:</strong> <%= counselor.getCounselorname() %></p>
                        <p><strong>Specialization:</strong> <%= counselor.getSpecialization() %></p>
                        <p><strong>Phone Number:</strong> <%= counselor.getPhoneC() %></p>
                    </div>
                </div>

                <div class="button">
                    <a href="StudentAppointmentBookingServlet?action=history" class="list">View My Appointments</a>
                    <a href="StudentAppointmentBookingServlet?action=loadDashboard" class="dashboard">Back to Dashboard</a>
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
    </body>
</html>