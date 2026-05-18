<%-- 
    Document   : question-staff
    Created on : 5 Mar 2025, 1:37:13 am
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
    <title>MINDEASE - Manage Assessment Questions</title>
    <style>
        .header {
            text-align: center;
            margin-top: 20px;
            color: #1e1b50;
        }
        
        .content p {
            text-align: center;
            margin-top: 25px;
            font-size: 20px;
            margin-bottom: 15px;
        }
        
        table {
            width: 80%; /* Reduce the width */
            margin: auto; /* Center it */
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 35px;
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
            width: 20px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 5px;
        }
        
        .add-btn {
            padding: 10px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px; 
            background-color: #007bff;
            width: fit-content;
            display: block;
            margin-left: auto;
            margin-right: auto;
            margin-top: 10px;
        }
        
        .add-btn a {
            text-decoration: none;
            color: white;
        }

        .button a {
            text-decoration: none;
            color: white;
            padding: 5px;
        }
        
        .edit-btn, .delete-btn {
            padding: 10px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .edit-btn {
            background-color: #007bff;
            color: white;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
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
            margin-top: 15px;
            color: white;
        }
        
        .fa-user-circle {
            color: white;
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
    
        <!-- Question list -->
        <div class="header">
            <h1>List of Questions</h1>
        </div>
        
        <button class="add-btn">
            <a href="addQuestion-staff.jsp">Add Question</a>
        </button>
        
        <div>
            <button id="exportUserPdf" class="btn btn-danger">
                <i class="fas fa-file-pdf me-2"></i> Print
            </button>
        </div>
        <table border="1" id="listQuestion">
            <thead>
                <tr>
                    <th>Question Text</th>
                    <th>Weight</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty questions}">
                <div class="content"><p>Number of questions: ${questions.size()}</p></div>
                    <c:forEach var="question" items="${questions}">
                        <tr>
                            <td>${question.questionText}</td>
                            <td>${question.weight}</td>
                            <td>${question.category}</td>
                            <td class="actions">
                                <div class="button">
                                    <a href="QuestionServlet?action=edit&questionID=${question.questionID}">
                                        <button class="edit-btn"><i class="fas fa-pencil-alt"></i></button>
                                    </a>
                                    <a href="QuestionServlet?action=delete&questionID=${question.questionID}" onclick="return confirm('Are you sure you want to delete this question?')">
                                        <button class="delete-btn"><i class="fas fa-trash-alt"></i></button>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>

                <c:if test="${empty questions}">
                    <tr>
                        <td colspan="5">No questions found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <!-- Load JS libraries once, and before usage -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

        <script>
            window.addEventListener("DOMContentLoaded", () => {
                const pdfBtn = document.getElementById("exportUserPdf");
                const table = document.getElementById("listQuestion");

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
