<%-- 
    Document   : submitFeedback
    Created on : 22 Jun 2025, 4:22:51 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <title>Student Give Feedback</title>
        <style>
             body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: #f4f6f9;
                display: flex;
            }
            
            .feedback-container {
                text-align: center;
                padding: 22px 0;
                margin-block-end: auto;
            }
            
            .feedback-container h1 {
                font-size: 28px;
                margin-bottom: 20px;
                color: #1e1b50;
            }
            
            .feedback-flexbox {
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .feedback-form {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                width: 100%;
                max-width: 500px;
            }
            
            .feedback-form h3 {
                margin-bottom: 10px;
            }

            .star-rating {
                direction: rtl;
                display: flex;
                justify-content: center;
                font-size: 2rem;
            }

            .star-rating input[type=radio] {
                display: none;
            }

            .star-rating label {
                color: #ccc;
                cursor: pointer;
                transition: color 0.2s;
            }

            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #f5b301;
            }
    
            textarea {
                width: 100%;
                padding: 10px;
                margin-top: 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                resize: vertical;
            }

            button {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #001744;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                display: block;
                width: 100%;
            }

            button:hover {
                background-color: #273c75;
            }

            .alert {
                text-align: center;
                font-weight: bold;
                color: green;
            }

            .error {
                text-align: center;
                font-weight: bold;
                color: red;
            }
            
            .feedback-btn, .delete-btn {
                padding: 10px 15px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .feedback-btn {
                background-color: #007bff;
                color: white;
                margin-right: 10px;
            }

            .delete-btn {
                background-color: #dc3545;
                color: white;
            }
            
            .fa-user-circle {
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
         
         <div class="feedback-container">
            <h1>Rate Your Counseling Session</h1>
            <div class="feedback-flexbox">     
                <c:if test="${not empty message}">
                    <script>
                        alert('${message}');
                        window.location.href = 'StudentAppointmentBookingServlet?action=history';
                    </script>
                </c:if>

                <c:if test="${not empty error}">
                    <script>
                        alert('${error}');
                        window.location.href = 'history-student.jsp';
                    </script>
                </c:if>    
                <div class="feedback-form">
                    <h3>Rating:</h3>
                    <form action="FeedbackServlet" method="post">
                        <input type="hidden" name="action" value="${empty feedback ? 'add' : 'edit'}" />
                        <input type="hidden" name="appointmentID" value="${appointmentID}" />
                        <input type="hidden" name="studentID" value="${studentID}" />

                        <div class="star-rating">
                            <c:forEach var="i" begin="1" end="5">
                            <c:set var="revIndex" value="${6 - i}" />
                                <input type="radio" id="star${revIndex}" name="rating" value="${revIndex}" <c:if test="${feedback.rating == revIndex}">checked</c:if>>
                                <label for="star${revIndex}" class="fas fa-star"></label>
                            </c:forEach>
                        </div><br><br>

                        <label>Comments:</label><br>
                        <textarea name="comments" rows="4" cols="50">${feedback.comments}</textarea><br><br>

                        <button class="feedback-btn" type="submit">${empty feedback ? 'Submit' : 'Update'} Feedback</button>
                    </form>

                    <c:if test="${not empty feedback}">
                        <form action="FeedbackServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this feedback?');">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="appointmentID" value="${appointmentID}" />
                            <input type="hidden" name="studentID" value="${studentID}" />
                            <button class="delete-btn" type="submit">Delete Feedback</button>
                        </form>
                    </c:if>
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
