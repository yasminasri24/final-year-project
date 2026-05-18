<%-- 
    Document   : viewFeedback-counselor
    Created on : 30 Jun 2025, 1:23:52 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js">
        <link rel="stylesheet" href="camstyle.css">
        <title>MINDEASE - View Feedback (Counselor)</title>
        <style>
            .fa-calendar-alt, .fa-user-circle {
                color: white;
            }
            
            .header {
                text-align: center;
                margin-top: 25px;
                color: #1e1b50;
            }
            
            .page-container {
                padding: 20px; /* Adjust padding for spacing */
                margin-top: -4%; /* Remove margin between navigation and content */
                text-align: center; /* Center align the heading */
                color: #1e1b50;
            }
            
            /* Styling for the container to center the table */
            .table-container {
                width: 80%; /* Adjust width as needed */
                margin: 20px auto; /* Center the table with top margin */
                padding: 10px;
                background-color: #f9f9f9; /* Light background for the container */
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for styling */
            }

            /* Styling for the table */
            table {
                width: 100%; /* Reduce the width */
                margin: auto; /* Center it */
                border-collapse: collapse;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Header styling */
            th {
                background-color: #4a3b78;
                color: white;
                text-align: center;
                padding: 10px;
                font-size: 17px;
                text-transform: uppercase;
            }

            /* Row styling */
            td {
                text-align: center;
                padding: 10px;
                font-size: 15px;
                border-bottom: 1px solid #ddd; /* Light border for rows */
            }

            /* Row hover effect */
            tr:hover {
                background-color: #f1f1f1; /* Light grey hover effect */
            }

            /* First and last rows border adjustment */
            tr:last-child td {
                border-bottom: none;
            }
            
            /* Mobile responsiveness */
            @media (max-width: 768px) {
                .table-container {
                    width: 100%; /* Full width for smaller screens */
                    padding: 5px;
                }

                th, td {
                    padding: 8px;
                    font-size: 15px; /* Adjust font size for smaller screens */
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
        
        <div class="header">
            <h1>Feedback List</h1> 
        </div>
        
        <div class="page-container">   
            <div class="table-container">
                <table border="1" cellpadding="10">
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Rating</th>
                            <th>Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fb" items="${feedbackList}">
                            <tr>
                                <td>${fb.studentname}</td>
                                <td><fmt:formatDate value="${fb.date}" pattern="dd-MM-yyyy"/></td>
                                <td>${fb.time}</td>
                                <td>
                                    <c:forEach begin="1" end="${fb.rating}" var="i">
                                        <i class="fas fa-star" style="color: #f5b301;"></i>
                                    </c:forEach>
                                    <c:forEach begin="1" end="${5 - fb.rating}" var="i">
                                        <i class="far fa-star" style="color: #f5b301;"></i>
                                    </c:forEach>
                                </td>
                                <td>${fb.comments}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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
