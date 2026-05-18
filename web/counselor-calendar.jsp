<%-- 
    Document   : counselor-calendar
    Created on : 24 Jun 2025, 7:46:45 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Counselor Calendar View</title>     
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js">
        <link rel="stylesheet" href="camstyle.css">
        <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
        <style>
            .fa-calendar-alt, .fa-user-circle {
                color: white;
            }
            
            .header-page {
                text-align: center;
                padding: 25px 0;
                color: #1e1b50;
            }
            
            .header-page h2 {
                font-size: 30px;
            }
            
            #calendar {
                max-width: 1500px;
                margin: auto;
                background: #fff;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                margin-bottom: 40px;
            }

            .fc-event {
                font-size: 14px;
                border: none;
                padding: 2px 4px;
                border-radius: 4px;
            }

            .legend {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin: 20px auto;
                font-size: 17px;
            }

            .legend span {
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .legend-box {
                width: 16px;
                height: 16px;
                border-radius: 4px;
                display: inline-block;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0; top: 0;
                width: 100%; height: 100%;
                background-color: rgba(0,0,0,0.4);
            }

            .modal-content {
                background: white;
                margin: 10% auto;
                padding: 20px;
                width: 90%;
                max-width: 500px;
                border-radius: 10px;
                position: relative;
            }

            .close-btn {
                position: absolute;
                right: 15px;
                top: 10px;
                font-size: 24px;
                cursor: pointer;
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
        
        <div class="header-page">
            <h2>Calendar View of Appointments</h2>
        </div>

        <div class="legend">
            <span><div class="legend-box" style="background-color: #007bff;"></div> Confirmed</span>
            <span><div class="legend-box" style="background-color: #28a745;"></div> Completed</span>
            <span><div class="legend-box" style="background-color: #dc3545;"></div> Rejected</span>
        </div>


        <div id="calendar"></div>

        <!-- Modal -->
        <div id="eventModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="document.getElementById('eventModal').style.display='none'">&times;</span>
                <h3>Appointment Details</h3>
                <p><strong>Student:</strong> <span id="modalStudent"></span></p>
                <p><strong>Category:</strong> <span id="modalCategory"></span></p>
                <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                <p><strong>Date:</strong> <span id="modalDate"></span></p>
                <p><strong>Time:</strong> <span id="modalTime"></span></p>
                <p><a id="viewAssessmentLink" href="#" target="_blank">View Assessment</a></p>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const calendarEl = document.getElementById('calendar');
                const calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    height: 'auto',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay'
                    },
                    events: [
                        <c:forEach var="appointment" items="${appointments}" varStatus="loop">
                            <c:set var="colorCode" value="#6c757d" />
                            <c:if test="${appointment.status == 'Completed'}"><c:set var="colorCode" value="#28a745" /></c:if>
                            <c:if test="${appointment.status == 'Confirmed'}"><c:set var="colorCode" value="#007bff" /></c:if>
                            <c:if test="${appointment.status == 'Rejected'}"><c:set var="colorCode" value="#dc3545" /></c:if>

                            {
                                id: '${appointment.appointmentID}',
                                title: '${fn:escapeXml(appointment.studentname)} - ${fn:escapeXml(appointment.category)}',
                                start: '${appointment.date}T${appointment.time}',
                                extendedProps: {
                                    student: '${fn:escapeXml(appointment.studentname)}',
                                    category: '${fn:escapeXml(appointment.category)}',
                                    status: '${appointment.status}',
                                    date: '${appointment.date}',
                                    time: '${appointment.time}',
                                    studentID: '${appointment.studentID}'
                                },
                                color: '${colorCode}'
                            }<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    eventClick: function(info) {
                        const props = info.event.extendedProps;
                        document.getElementById('modalStudent').innerText = props.student;
                        document.getElementById('modalCategory').innerText = props.category;
                        document.getElementById('modalStatus').innerText = props.status;
                        document.getElementById('modalDate').innerText = props.date;
                        document.getElementById('modalTime').innerText = props.time;
                        document.getElementById('viewAssessmentLink').href =
                            'CounselorAppointmentServlet?action=viewAssessment&studentID=' + props.studentID;

                        document.getElementById('eventModal').style.display = 'block';
                    }
                });
                calendar.render();
            });

            // Close modal if clicking outside it
            window.onclick = function(event) {
                const modal = document.getElementById('eventModal');
                if (event.target === modal) {
                    modal.style.display = "none";
                }
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
