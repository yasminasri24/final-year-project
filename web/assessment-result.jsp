<%-- 
    Document   : assessment-result
    Created on : 17 Jan 2025, 7:10:56 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>MINDEASE - Student Dashboard</title>
    <style>
        .fa-user-circle {
            color: white;
        }
        
        .result-header h1 {
            color: #1e1b50;
            font-size: 35px;
            text-align: center;
            font-weight: bold;
            font-family: sans-serif;
            margin-bottom: 15px;
            margin-top: 15px;
        }

        .result-header p {
            text-align: center;
            font-size: 20px;
            color: black;
            font-family: sans-serif;
        }

        .results {
            display: flex;
            flex-direction: column;
            gap: 5px;
            margin: 20px auto;
            align-items: stretch;
            width: 65%;
        }

        .result-box {
            background-color: #605c95;
            color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: justify;
        }

        .result-box h2 {
            margin: 0 0 15px 0;
            font-size: 20px;
        }

        .result-box p {
            margin: 5px 0 0;
            font-size: 20px;
        }

        .actions {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 20px;
        }
        
        .recommendation-box h2 {
            margin-bottom: 5px;
        }
        
        .recommendation-box p {
            font-size: 20px;
            color: black;
        }

        .actions button {
            background-color: #2c2b5f;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            margin-top: -2%;
            margin-bottom: 15px;
        }

        .actions button:hover {
            background-color: #443e87;
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
    
    <div class="result-header">
        <h1>Depression, Anxiety, Stress Scale (DASS) Test Result</h1>
        <p>Thank you for answering this assessment. Here is your result:</p>
    </div>
    
    <div class="results">
        <div class="result-box">
            <h2><strong>Depression</strong></h2>
            <p>Score: <%= request.getAttribute("depressionScore") %> (<%= request.getAttribute("depressionResult") %>)</p>
        </div>  
        <div class="result-box">
            <h2><strong>Anxiety</strong></h2>
            <p>Score: <%= request.getAttribute("anxietyScore") %> (<%= request.getAttribute("anxietyResult") %>)</p>
        </div>
        <div class="result-box">
            <h2><strong>Stress</strong></h2>
            <p>Score: <%= request.getAttribute("stressScore") %> (<%= request.getAttribute("stressResult") %>)</p>
        </div>
        <div class="recommendation-box">
            <h2><strong>Recommendation:</strong></h2> 
            <p> <%= request.getAttribute("recommendation") %></p>
        </div>
    </div>
        
    <div class="actions">
        <button onclick="window.location.href='studentDashboard.jsp'">Home</button>
        <button onclick="window.location.href='appointment-student.jsp'">Book an appointment</button>
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

<%! 
public String interpretScore(int score, String category) {
    if (category.equals("depression")) {
        if (score <= 9) return "Normal";
        else if (score <= 13) return "Mild";
        else if (score <= 20) return "Moderate";
        else if (score <= 27) return "Severe";
        else return "Extremely Severe";
    } else if (category.equals("anxiety")) {
        if (score <= 7) return "Normal";
        else if (score <= 9) return "Mild";
        else if (score <= 14) return "Moderate";
        else if (score <= 19) return "Severe";
        else return "Extremely Severe";
    } else if (category.equals("stress")) {
        if (score <= 14) return "Normal";
        else if (score <= 18) return "Mild";
        else if (score <= 25) return "Moderate";
        else if (score <= 33) return "Severe";
        else return "Extremely Severe";
    }
    return "Unknown";
}
%>

