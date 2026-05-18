<%-- 
    Document   : GenerateReferral
    Created on : 25 Jun 2025, 12:40:01 am
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <link rel="stylesheet" href="camstyle.css">
        <title>Generate Referral Letter - Counselor</title>
        <style>
        .container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .container h2 {
            text-align: center;
            color: #333333;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            color: #333333;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            margin-top: 8px;
            border: 1px solid #cccccc;
            border-radius: 6px;
            font-size: 15px;
            background-color: #fafafa;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
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
        
        <div class="container">
            <h2>Generate Referral Letter (PDF)</h2>
            <form action="GenerateReferralPDFServlet" method="get" target="_blank">
                <!-- Hidden IDs -->
                <input type="hidden" name="studentID" value="${param.studentID}">
                <input type="hidden" name="counselorID" value="${param.counselorID}">
                <input type="hidden" name="appointmentID" value="${param.appointmentID}">


                <!-- Referral To -->
                <label for="referralTo">Referral To (e.g., Psychiatrist, Clinic Name):</label>
                <input type="text" id="referralTo" name="referralTo" required>

                <!-- Reason -->
                <label for="reason">Reason for Referral:</label>
                <textarea id="reason" name="reason" placeholder="Explain why the student is being referred..." required></textarea>

                <!-- Notes -->
                <label for="notes">Additional Notes / Recommendations:</label>
                <textarea id="notes" name="notes" placeholder="Optional notes or advice for the referred party..."></textarea>

                <div class="form-buttons">
                    <button type="submit" class="save-btn">Generate Letter</button>
                    <button type="button" class="cancel-btn" onclick="goBack()">Cancel</button>
                </div>
            </form>
        </div>
                
        <script>
            function goBack() {
                window.location.href = "CounselorAppointmentServlet?view=all"; 
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
