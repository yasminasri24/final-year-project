<%-- 
    Document   : appointment-staff
    Created on : 20 May 2025, 2:54:37 pm
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*, com.Model.Appointment, 
         com.Model.Student, com.Model.Counselor" %>
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
    <title>MINDEASE - List of Student Appointment</title>
    <style>
        .header {
            text-align: center;
            margin-top: 40px;
            color: #1e1b50;
            margin-bottom: 25px;
        }
        
        .fa-user-circle {
            color: white;
        }
        
        table {
            max-width: 1200px;
            margin: auto; /* Center it */
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 45px;
            margin-bottom: 25px;
        }
        
        table, th, td {
            border: 1px solid #ccc;
        }
        
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #4a3b78;
            color: white;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .actions {
            display: flex;
            justify-content: center;
            gap: 5px;
        }
        
        .button a {
            text-decoration: none;
            color: white;
            padding: 5px;
        }
        
        .action-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            width: 45px;
        }
        .edit-btn {
            color: blue;
        }
        .delete-btn {
            color: red;
        }
        
        .btn-danger {
            margin: auto;
            display: block;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px; 
            background-color: #c0392b;
            width: fit-content;
            margin-top: 10px;
            color: white;
            margin-bottom: 10px;
        }
        
        .form-filter {
            margin: auto;
            font-size: 16px;
        }
        
        .form-filter label, option {
            font-size: 16px;
        }
        
        .form-filter select {
            padding: 8px 8px;
            border-radius: 5px;
            border: 3px solid #ccc;
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
        
        <div class="header">
            <h2>All Appointments Booked by Students</h2>
        </div>
        
        <div class="form-filter">
            <form method="get" action="StaffAppointmentServlet" class="mb-3">
                <input type="hidden" name="action" value="adminList" />
                <label for="status">Filter by Status:</label>
                <select name="status" id="status" onchange="this.form.submit()">
                    <c:set var="selectedStatus" value="${selectedStatus}" />
                    <option value="">All</option>
                    <option value="Pending" <c:if test="${selectedStatus == 'Pending'}">selected</c:if>>Pending</option>
                    <option value="Confirmed" <c:if test="${selectedStatus == 'Confirmed'}">selected</c:if>>Confirmed</option>
                    <option value="Completed" <c:if test="${selectedStatus == 'Completed'}">selected</c:if>>Completed</option>
                    <option value="Rejected" <c:if test="${selectedStatus == 'Rejected'}">selected</c:if>>Rejected</option>
                    <option value="Cancelled" <c:if test="${selectedStatus == 'Cancelled'}">selected</c:if>>Cancelled</option>
                </select>
            </form>
        </div>

        <c:choose>
            <c:when test="${not empty appointments}">
                <table border="1" cellpadding="10" id="apptTable">
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Student Name</th>
                        <th>Student Phone</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Counselor Name</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="a" items="${appointments}">
                        <tr>
                            <td><fmt:formatDate value="${a.date}" pattern="dd-MM-yyyy" /></td>
                            <td>${a.time}</td>
                            <td>${a.student.studentName}</td>
                            <td>${a.student.phoneS}</td>
                            <td>${a.category}</td>
                            <td>${a.typeCounseling}</td>
                            <td>${a.counselor.counselorname}</td>
                            <td>${a.status}</td>
                            <td class="actions">
                                <a href="StaffAppointmentServlet?action=delete&appointmentID=${a.appointmentID}" onclick="return confirm('Are you sure you want to delete this appointment?');">
                                    <button class="action-btn delete-btn"><i class="fas fa-trash-alt"></i></button>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <p>No appointments found.</p>
            </c:otherwise>
        </c:choose>
                
        <div>
            <button id="exportUserPdf" class="btn btn-danger">
                <i class="fas fa-file-pdf me-2"></i> Print
            </button>
        </div>


        <!-- Load JS libraries once, and before usage -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

        <script>
            window.addEventListener("DOMContentLoaded", () => {
                const pdfBtn = document.getElementById("exportUserPdf");
                const table = document.getElementById("apptTable");

                // Export to PDF (view in browser)
                pdfBtn.addEventListener("click", () => {
                    html2canvas(table).then((canvasObj) => {
                        const imgData = canvasObj.toDataURL("image/png");
                        const { jsPDF } = window.jspdf;
                        const pdf = new jsPDF();
                        pdf.addImage(imgData, 'PNG', 10, 10, 190, 0);

                        // Preview the PDF in a new tab instead of downloading
                        const pdfBlob = pdf.output("blob");
                        const pdfUrl = URL.createObjectURL(pdfBlob);
                        window.open(pdfUrl); // Open in new tab
                    });
                });
            });
        </script>
        
        <!-- Footer -->
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
        
        <c:if test="${not empty sessionScope.message}">
            <script>
                alert("${sessionScope.message}");
            </script>
            <c:remove var="message" scope="session"/>
        </c:if>
            
    </body>
</html>
