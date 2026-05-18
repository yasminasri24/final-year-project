<%-- 
    Document   : counselor-appointments
    Created on : 23 Jun 2025, 3:51:09 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Counselor Appointments</title>
        <style>
            body { 
                font-family: Arial; 
                background-color: #f8f9fa; 
            }
            
            .header {
                text-align: center;
                margin-top: 25px;
                color: #1e1b50;
            }

            .container { 
                max-width: max-content;
                margin: auto; 
                background: #fff; 
                padding: 30px; 
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .container h2 {
                margin-bottom: 15px;
            }

            table { 
                width: 100%;
                border-collapse: collapse; 
                margin-top: 20px;
            }

            th, td { 
                padding: 12px; 
                text-align: center; 
                border: 1px solid #ddd; 
                font-size: 15px;
            }

            th { 
                background-color: #f1f1f1; 
            }

            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 15px;
                color: white;
            }

            .badge-confirmed { 
                background-color: #007bff; 
            }

            .badge-completed { 
                background-color: #28a745; 
            }

            .badge-rejected { 
                background-color: #dc3545;
            }

            .filters {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .filters input, .filters select {
                padding: 10px 10px;
                border-radius: 5px;
                border: 3px solid #ccc;
                padding: 10px 10px;
            }

            .filters button {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 5px;
                font-size: 15px;
                cursor: pointer;
                text-decoration: none;  
            }

            .notes {
                max-width: 250px;
                text-align: left;
                font-size: 15px;
            }

            .btn-view, .btn-refer {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 5px;
                font-size: 15px;
                cursor: pointer;
                text-decoration: none;
            }
            .btn-view:hover {
                background-color: #0056b3;
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

        <c:if test="${not empty sessionScope.noteMessage}">
            <script>
                alert("${sessionScope.noteMessage}");
            </script>
            <c:remove var="noteMessage" scope="session" />
        </c:if>
            
        <div class="header">
            <h1>All Assigned Appointments</h1>
        </div>
            
        <div class="container">
            <!-- 🔍 Filter & Search -->
            <div class="filters">
                <form method="get" action="CounselorAppointmentServlet">
                    <input type="text" name="search" placeholder="Search by student name" value="${param.search}" />
                    <select name="statusFilter">
                        <option value="">All Status</option>
                        <option value="Confirmed" ${param.statusFilter == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                        <option value="Completed" ${param.statusFilter == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Rejected" ${param.statusFilter == 'Rejected' ? 'selected' : ''}>Rejected</option>
                    </select>
                    <input type="hidden" name="view" value="all" />
                    <button type="submit">Filter</button>
                </form>
            </div>

            <!-- 🧾 Appointments Table -->
            <c:choose>
                <c:when test="${not empty appointments}">
                    <table>
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Type</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Notes</th>
                                <th>Assessment</th>
                                <th>Referral</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="appointment" items="${appointments}">
                                <tr>
                                    <td>${appointment.studentname}</td>
                                    <td><fmt:formatDate value="${appointment.date}" pattern="dd-MM-yyyy" /></td>
                                    <td>${appointment.time}</td>
                                    <td>${appointment.typeCounseling}</td>
                                    <td>${appointment.category}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${appointment.status == 'Confirmed'}">
                                                <span class="badge badge-confirmed">Confirmed</span>
                                            </c:when>
                                            <c:when test="${appointment.status == 'Completed'}">
                                                <span class="badge badge-completed">Completed</span>
                                            </c:when>
                                            <c:when test="${appointment.status == 'Rejected'}">
                                                <span class="badge badge-rejected">Rejected</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${appointment.status}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="notes">
                                        <c:if test="${not empty appointment.notes}">
                                            ${appointment.notes}
                                        </c:if>
                                        <c:if test="${empty appointment.notes && appointment.status == 'Completed'}">
                                            <a href="CounselorAppointmentServlet?action=noteform&appointmentID=${appointment.appointmentID}">Add Notes</a>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${appointment.status == 'Completed'}">
                                            <a href="CounselorAppointmentServlet?action=viewAssessment&studentID=${appointment.studentID}" class="btn-view">
                                                View Assessment
                                            </a>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${appointment.status == 'Completed'}">
                                            <form action="GenerateReferral.jsp" method="get">
                                                <input type="hidden" name="studentID" value="${appointment.studentID}">
                                                <input type="hidden" name="appointmentID" value="${appointment.appointmentID}">
                                                <input type="hidden" name="counselorID" value="${sessionScope.counselorID}">
                                                <button class="btn-refer" type="submit">Refer</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No appointments found.</p>
                </c:otherwise>
            </c:choose>
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
