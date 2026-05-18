<%-- 
    Document   : history-student
    Created on : 18 May 2025, 5:40:21 pm
    Author     : DELL
--%>

<%@page import="com.Model.Appointment"%>
<%@page import="com.Model.Counselor"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>Appointment History - Student</title>
    <style>
        .fa-user-circle {
            color: white;
        }
        
        .header {
            text-align: center;
            margin-top: 40px;
            color: #1e1b50;
        }
        
        table {
            width: 80%; /* Reduce the width */
            max-width: 980px; /* Prevent it from being too wide */
            margin: auto; /* Center it */
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 45px;
        }
        
        table, th, td {
            border: 1px solid #ccc;
        }
        
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 16px;
        }
        
        th {
            background-color: #4a3b78;
            color: white;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            background-color: #27ae60;
            color: white;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #219150;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            table {
                width: 95%;
            }

            th, td {
                padding: 8px;
                font-size: 14px;
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
        
        <div class="header">
           <h1>Appointment History</h1> 
        </div>
          
        <c:choose>
            <c:when test="${not empty appointments}">
                <table border="1" cellpadding="10">
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Counselor</th>
                        <th>Contact</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="a" items="${appointments}">
                        <tr>
                            <td><fmt:formatDate value="${a.date}" pattern="dd-MM-yyyy" /></td>
                            <td>${a.time}</td>
                            <td>${a.category}</td>
                            <td>${a.typeCounseling}</td>
                            <td>${a.counselor.counselorname}</td>
                            <td>${a.counselor.phoneC}</td>
                            <td>${a.status}</td>
                            <td>
                            <c:choose>
                                <c:when test="${a.status == 'Completed'}">
                                    <c:choose>
                                        <c:when test="${a.feedbackSubmitted}">
                                            <form action="FeedbackServlet" method="get">
                                                <input type="hidden" name="action" value="edit" />
                                                <input type="hidden" name="appointmentID" value="${a.appointmentID}" />
                                                <input type="hidden" name="studentID" value="${sessionScope.studentID}" />
                                                <button type="submit">Edit Feedback</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="FeedbackServlet" method="get">
                                                <input type="hidden" name="action" value="edit" />
                                                <input type="hidden" name="appointmentID" value="${a.appointmentID}" />
                                                <input type="hidden" name="studentID" value="${sessionScope.studentID}" />
                                                <button type="submit">Give Feedback</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span>-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <p>No appointment history found.</p>
            </c:otherwise>
        </c:choose>
                
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
