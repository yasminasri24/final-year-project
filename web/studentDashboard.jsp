<%-- 
    Document   : studentDashboard
    Created on : 15 Jan 2025, 4:06:34 am
    Author     : DELL
--%>

<%@page import="com.DAO.AppointmentDAO"%>
<%@page import="com.Model.Counselor"%>
<%@page import="com.Model.Appointment"%>
<%@page import="com.Util.DBConnection"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Model.Assessment" %>
<%@ page import="com.DAO.AssessmentDAO" %>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    Integer studentID = (Integer) session.getAttribute("studentID");
    Assessment latestAssessment = null;
    
    if (studentID != null) {
        try (Connection conn = DBConnection.getConnection()) {
            AssessmentDAO assessmentDAO = new AssessmentDAO(conn);
            latestAssessment = assessmentDAO.getLatestAssessmentByStudentID(studentID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
%>
<%
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
%>
    <script>
        alert("<%= successMessage %>");
    </script>
<%
        session.removeAttribute("successMessage");
    }
%>
<%
    String updateSuccess = request.getParameter("updateSuccess");
    if (updateSuccess != null && updateSuccess.equals("true")) {
%>
    <script>
        alert("Appointment updated successfully!");
    </script>
<%
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
    <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="camstyle.css">
    <title>MINDEASE - Student Dashboard</title>
    <style>
        /* Dashboard Header */
        .dashboard-header {
            text-align: center;
            padding: 25px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-block-end: auto;
        }

        .dashboard-header h1 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .dashboard-header p {
            font-size: 24px;
            color: #555;
            font-family: cursive;
        }
        
        /* Dashboard Content */
        .dashboard-content {
            display: flex;
            justify-content: space-between;
            margin: auto;
            max-width: 1200px;
            gap: 40px;
            flex-direction: row;
            align-items: stretch;
            margin-block-end: auto;
            margin-bottom: auto;
            margin-top: -40px;
        }

        .dashboard-card {
            background-color: #5d5d97; /* Muted purple */
            border-radius: 15px;
            padding: 25px;
            color: #ffffff;
            width: 45%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .dashboard-card h2 {
            font-size: 22px;
            margin-bottom: 15px;
            text-align: center;
            color: #ffffff;
        }

        .dashboard-card p {
            font-size: 16px;
            margin: revert;
            text-align: -webkit-center-;
        }

        .dashboard-card .appointment-details,
        .dashboard-card .assessment-details {
            background-color: #2e2d61; /* Darker purple */
            border-radius: 8px;
            padding: 15px;
            color: #ffffff;
            text-align: left;
        }

        .dashboard-card .status {
            background-color: #7e8ce0; /* Light grayish blue */
            padding: 10px 10px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }

        .dashboard-card .alert {
            margin-top: 15px;
            font-size: 16px;
            padding: 12px;
            color: #fff;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }
        
        .alert i {
            color: #e74c3c; /* Red color for the alert icon */
            margin-right: 10px;
            font-size: 18px;
        }

        .dashboard-card .alert img {
            height: 20px;
            margin-right: 10px;
        }
        
        .edit-button, .delete-button {
            padding: 10px 18px;
            font-size: 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            margin-right: 10px;
        }
        
        .edit-button {
            background-color: #007bff;
            color: white;
        }

        .delete-button {
            background-color: #dc3545;
            color: white;
        }
        
        .fa-user-circle {
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-content {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-card {
                width: 90%;
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

    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>!</h1>
        <p>You don’t drown by falling in the water; you drown by staying there.</p>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">   
        <!-- Upcoming Appointment Section -->
        <div class="dashboard-card">
            <h2>Upcoming Appointment</h2>
            <div class="appointment-details">
                <%
                    Appointment appointment = (Appointment) request.getAttribute("upcomingAppointment");
                    if (appointment != null) {
                        Counselor counselor = appointment.getCounselor();
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
                        String formattedDate = sdf.format(appointment.getDate());
                %>
                    <p><strong>Date:</strong> <%= formattedDate %></p>
                    <p><strong>Time:</strong> <%= appointment.getTime() %></p>
                    <p><strong>Category:</strong> <%= appointment.getCategory() %></p>
                    <p><strong>Type:</strong> <%= appointment.getTypeCounseling() %></p>
                    <p><strong>Counselor:</strong> <%= counselor.getCounselorname() %></p>
                    <p><strong>Contact:</strong> <%= counselor.getPhoneC() %></p>
                    
                    <div style="margin-top: 15px; display: flex; justify-content: center;">
                        <a class="edit-button" href="StudentAppointmentBookingServlet?action=editForm&appointmentID=<%= appointment.getAppointmentID() %>">Update</a>

                        <form action="StudentAppointmentBookingServlet" method="post" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="appointmentID" value="<%= appointment.getAppointmentID() %>">
                            <input type="submit" value="Cancel" class="delete-button">
                        </form>
                    </div>
            <%
                } else {
            %>
                <p>No upcoming appointments.</p>
            <%
                }
            %>
            </div>
        </div>

        <!-- Assessment Section -->
        <div class="dashboard-card">
            <h2>Assessment</h2>
            <div class="assessment-details">
                <% if (latestAssessment != null) { %>
                <p><strong>Depression Score:</strong> <%= latestAssessment.getDepressionScore() %> (<%= latestAssessment.getDepressionResult() %>)</p>
                <p><strong>Anxiety Score:</strong> <%= latestAssessment.getAnxietyScore() %> (<%= latestAssessment.getAnxietyResult() %>)</p>
                <p><strong>Stress Score:</strong> <%= latestAssessment.getStressScore() %> (<%= latestAssessment.getStressResult() %>)</p>
                <p><strong>Recommendation:</strong> <%= latestAssessment.getRecommendation() %></p>
            <% } else { %>
                <p>No assessments found. Please complete an assessment to view results.</p>
            <% } %>
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
