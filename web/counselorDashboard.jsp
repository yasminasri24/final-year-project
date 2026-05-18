<%-- 
    Document   : counselorDashboard
    Created on : 15 Jan 2025, 4:11:28 am
    Author     : DELL
--%>

<%@page import="com.Model.Appointment"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js">
    <link rel="stylesheet" href="camstyle.css">
    <title>MINDEASE - Counselor Dashboard</title>
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
        
        .appointments-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
            max-width: 700px;
        }

        .appointment-card {
            background-color: #5d5d97; /* Muted purple */
            border-radius: 15px;
            padding: 25px;
            color: #ffffff;
            width: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
         .appointment-card h3 {
            font-size: 20px;
            margin-bottom: 15px;
            text-align: center;
            color: #ffffff;
        }

        .appointment-card p {
            font-size: 17px;
            margin: 10px 0;
        }
        
        .pending-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 10px;
        }
        
        .task-details {
            background-color: #2f2f75;
            padding: 15px;
            border-radius: 10px;
            color: white;
        }

        .appointment-card .appointment-details,
        .task-details {
            background-color: #2e2d61; /* Darker purple */
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 18px;
            color: #ffffff;
        }

        .task-details .button-group {
            display: flex;
            justify-content: start; /* Align buttons to the left */
            gap: 10px; /* Add spacing between buttons */
            margin-top: 10px;
        }

        .btn-confirm, .btn-reject {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-confirm {
            background-color: #27ae60;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn-confirm:hover {
            background-color: #219150;
        }

        .btn-reject {
            background-color: #e74c3c;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn-reject:hover {
            background-color: #c0392b;
        }
        
        .dashboard-flex-wrapper {
            display: flex;
            justify-content: center;      /* Center the whole row */
            align-items: flex-start;
            gap: 130px;
            margin-top: 40px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }
        
        .pie-chart-box {
            flex: 0 0 350px;
            border: 2px solid #ccc;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        .stats-boxes {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
            margin-top: 20px;
        }
        
        .stat-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            width: 30%;
            font-size: 18px;
        }
        
        .stat-box span {
            font-size: 28px;
            font-weight: bold;
            display: block;
            margin-top: 5px;
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
    
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>!</h1>
        <p>Talent is nothing without persistence.</p>
    </div>
        
    <div class="stats-boxes">
        <div class="stat-box confirmed">
            Confirmed
            <span>${countConfirmed}</span>
        </div>
        <div class="stat-box completed">
            Completed
            <span>${countCompleted}</span>
        </div>
        <div class="stat-box rejected">
            Rejected
            <span>${countRejected}</span>
        </div>
    </div>

    <div class="dashboard-flex-wrapper">
        <div class="pie-chart-box">
            <canvas id="typeChart" width="300" height="300"></canvas>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const ctx = document.getElementById('typeChart');
            const typeChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Personal', 'Academic', 'Mental Health', 'Finance', 'Social', 'Career'],
                    datasets: [{
                        data: [
                            ${personalCount},
                            ${academicCount},
                            ${mentalCount},
                            ${financeCount},
                            ${socialCount},
                            ${careerCount}
                        ],
                        backgroundColor: [
                            '#6f42c1', // Personal
                            '#36A2EB', // Academic
                            '#FF6384', // Mental Health
                            '#ffc107', // Finance
                            '#20c997', // Social
                            '#007bff'  // Career
                        ]
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        </script>

        <div class="appointments-section">
            <!-- Today's Appointments -->
            <div class="appointment-card">
                <h3>Today's Appointments</h3>
                <c:choose>
                    <c:when test="${not empty todaysAppointments}">
                        <c:forEach var="appointment" items="${todaysAppointments}">
                            <div class="appointment-details">
                                <p><strong>Student:</strong> ${appointment.studentname}</p>
                                <p><strong>Type of Counseling:</strong> ${appointment.typeCounseling}</p>
                                <p><strong>Category:</strong> ${appointment.category}</p>
                                <p><i class="fas fa-calendar-alt"></i> 
                                    <fmt:formatDate value="${appointment.date}" pattern="dd-MM-yyyy" />
                                </p>
                                <p><i class="fas fa-clock"></i> ${appointment.time}</p>

                                <div class="button-group">
                                    <form action="CounselorAppointmentServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="complete" />
                                        <input type="hidden" name="appointmentID" value="${appointment.appointmentID}" />
                                        <button type="submit" class="btn-confirm">Completed</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>No appointments scheduled for today.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pending Tasks -->
            <div class="appointment-card">
                <h3>Pending Appointments</h3>
                <div class="pending-grid">
                    <c:choose>
                        <c:when test="${not empty pendingTasks}">
                            <c:forEach var="task" items="${pendingTasks}">
                                <div class="task-details">
                                    <p><strong>Student:</strong> ${task.studentname}</p>
                                    <p><strong>Type of Counseling:</strong> ${task.typeCounseling}</p>
                                    <p><strong>Category:</strong> ${task.category}</p>
                                    <p><i class="fas fa-calendar-alt"></i> 
                                        <fmt:formatDate value="${task.date}" pattern="dd-MM-yyyy" />
                                    </p>
                                    <p><i class="fas fa-clock"></i> ${task.time}</p>

                                    <div class="button-group">
                                        <form action="CounselorAppointmentServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="confirm" />
                                            <input type="hidden" name="appointmentID" value="${task.appointmentID}" />
                                            <button type="submit" class="btn-confirm">Confirm</button>
                                        </form>

                                        <form action="CounselorAppointmentServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="reject" />
                                            <input type="hidden" name="appointmentID" value="${task.appointmentID}" />
                                            <button type="submit" class="btn-reject">Reject</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>No pending appointments at the moment.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
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
