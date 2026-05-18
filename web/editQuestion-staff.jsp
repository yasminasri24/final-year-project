<%-- 
    Document   : editQuestion-staff
    Created on : 5 Mar 2025, 3:56:18 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>MINDEASE - Edit Assessment Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        
        .fa-user-circle {
            color: white;
        }
        
        .container {
            text-align: center;
            display: ruby;
        }

        .card {
            background-color: #505081; /* Dark purple */
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.2); /* Soft shadow */
            width: 350px; /* Limit width */
            margin-top: -50px; /* Adjust form position */
        }

        h2 {
            color: white;
            margin-bottom: 15px;
        }

        label {
            display: block;
            color: white;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: left;
        }

        input, select, textarea {
            width:90%;
            padding: 8px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }

        button {
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .update-btn {
            background-color: #007bff;
            color: white;
        }

        .cancel-btn {
            background-color: #dc3545;
            color: white;
        }
        
        button a {
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
                    <li><a href="UserServlet?action=list">User Account</a></li>
                    <li><a href="QuestionServlet?action=list">Assessment Question</a></li>
                    <li><a href="assessment-staff.jsp">Assessment</a></li>
                    <li><a href="StaffAppointmentServlet?action=adminList">Appointment</a></li>        
                    <li><a href="FeedbackServlet?action=viewAll">Feedback</a></li>
                </ul>
            </div>
            <div class="navbar-center">
                <h1><a href="StaffServlet?action=showDashboard"" style="text-decoration: none; color: aliceblue;">Admin Dashboard</a></h1>
            </div>
            <div class="navbar-right">
                <div class="icons">
                    <i class="fas fa-headset"></i> <!-- Headset icon -->
                    <i class="fas fa-bell"></i> <!-- Notification icon -->
                    <a href="StaffServlet?action=profile" title="View Profile">
                        <i class="fas fa-user-circle"></i> <!-- Profile icon -->
                    </a>
                </div>
            </div>
        </div>
        
        <div class="container">
            <div class="card">
                <!-- Edit Form -->
                <h2>Edit Question</h2>

                <!-- If the user object is not null, display the form to edit the user -->
                <c:if test="${not empty question}">
                    <form action="QuestionServlet?action=update" method="post">
                        <input type="hidden" name="questionID" value="${question.questionID}">

                        <label for="questionText">Question Text: </label>
                        <input type="text" id="questionText" name="questionText" value="${question.questionText}" required>

                        <label for="weight">Weight: </label>
                        <input type="number" id="weight" name="weight" value="${question.weight}" required>
                        
                        <label for="category">Category: </label>
                        <select id="category" name="category" value="${question.category}" required>
                            <option value="">Select category</option>
                            <option value="Stress">Stress</option>
                            <option value="Anxiety">Anxiety</option>
                            <option value="Depression">Depression</option>
                        </select>

                        <div class="btn-container">
                            <button class="update-btn" type="submit">Update</button>
                            <button class="cancel-btn"><a href="QuestionServlet?action=list" class="btn btn-secondary">Cancel</a></button>
                        </div>
                    </form>
                </c:if>
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
