<%-- 
    Document   : appointment-student
    Created on : 5 May 2025, 1:45:13 pm
    Author     : DELL
--%>

<%@page import="java.sql.Time"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*" %>

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
        <title>MINDEASE - Book Counseling Appointment (Student)</title>
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

            .appt-container {
                text-align: center;
                padding: 22px 0;
                margin-block-end: auto;
            }
            
            .appt-container h1 {
                font-size: 28px;
                margin-bottom: 20px;
                color: #1e1b50;
            }
            
            .appt-flexbox {
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .appt-form {
                background-color: #322f6d;
                padding: 20px;
                border-radius: 10px;
                width: 400px;
                color: white;
            }

            .appt-slots {
                width: 250px;
            }

            .error-msg {
                background-color: #ffe6e6;
                color: #d8000c;
                padding: 10px;
                border: 1px solid #f44336;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .slots-box {
                background-color: #f9f9f9;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                color: #333;
            }

            .slots-list {
                list-style-type: none;
                padding-left: 0;
            }

            .slot-item {
                cursor: pointer;
                padding: 5px;
                margin: 5px 0;
                border-radius: 4px;
                background-color: #e0e0e0;
                transition: background-color 0.2s;
            }

            .slot-item:hover {
                background-color: #d1cfcf;
            }
       
            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: table;
                margin-bottom: 5px;
                font-size: 16px;
            }

            .form-group input, .form-group select {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 4px;
                font-size: 15px;
            }

            .form-group input:focus, .form-group select:focus {
                outline: none;
                box-shadow: 0 0 5px #5a5ae6;
            }
            
            .form-group button {
                width: 100%;
                padding: 10px;
                font-size: 15px;
                background-color: #272757;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-top: 10px;
            }

            .form-group button:hover {
                background-color: #4848b4;
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
        
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            List<Time> availableSlots = (List<Time>) request.getAttribute("availableSlots");
        %>
        
        <div class="appt-container">
            <h1>Book Counseling Appointment</h1>
            <div class="appt-flexbox">
                <!-- Form Column -->
                <div class="appt-form">
                    <form action="StudentAppointmentBookingServlet?action=book" method="post">
                        <div class="form-group">
                            <label for="typeCounseling">Type of Counseling:</label><br>
                            <select name="typeCounseling" id="typeOfCounseling" required onchange="toggleGroupField(this.value)">
                                <option value="">Select</option>
                                <option value="Individual">Individual</option>
                                <option value="Group">Group</option>
                            </select><br><br>

                            <div id="groupParticipantsField" style="display:none;">
                                <label>Group Participants (names, comma-separated):</label><br>
                                <textarea name="groupMembers" rows="3" cols="30"></textarea><br><br>
                            </div>

                            <label>Category:</label><br>
                            <select name="category" required>
                                <option value="">Select</option>
                                <option value="Personal">Personal</option>
                                <option value="Academic">Academic</option>
                                <option value="Mental Health">Mental Health</option>
                                <option value="Finance">Finance</option>
                                <option value="Social">Social</option>
                                <option value="Career">Career</option>
                            </select><br><br>

                            <label>Date:</label><br>
                            <input type="date" name="date" required><br><br>

                            <label>Time:</label><br>
                            <input type="time" name="time" id="timeInput" required><br><br>

                            <button type="submit" value="Book Appointment">Book Appointment</button>
                        </div>
                    </form>
                </div>

                <!-- Time Slots Column -->
                <% if (errorMessage != null) { %>
                <div class="appt-slots">
                    <div class="error-msg">
                        <strong><%= errorMessage %></strong>
                    </div>

                    <% if (availableSlots != null && !availableSlots.isEmpty()) { %>
                        <div class="slots-box">
                            <strong>Available time slots:</strong>
                            <ul class="slots-list">
                                <% for (Time slot : availableSlots) {
                                    String timeStr = slot.toString().substring(0, 5); %>
                                    <li class="slot-item" onclick="selectTime('<%= timeStr %>')"><%= timeStr %></li>
                                <% } %>
                            </ul>
                        </div>
                    <% } else { %>
                        <div class="slots-box">
                            <strong>No available time slots for this date.</strong>
                        </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            function toggleGroupField(value) {
                const groupField = document.getElementById("groupParticipantsField");
                groupField.style.display = (value === "Group") ? "block" : "none";
            }

            function selectTime(time) {
                document.getElementById("timeInput").value = time;
            }
        </script>
         
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
