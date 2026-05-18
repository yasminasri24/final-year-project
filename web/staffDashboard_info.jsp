<%-- 
    Document   : staffDashboard
    Created on : 15 Jan 2025, 4:11:44 am
    Author     : DELL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (session.getAttribute("studentCount") == null) {
        response.sendRedirect("StaffServlet?action=showDashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <link rel="stylesheet" href="camstyle.css">
    <title>MINDEASE - Staff Dashboard</title>
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
        
        h3 {
            margin: auto;
            margin-bottom: 20px;
            margin-top: 15px;
            font-size: 25px;
        }
        
        canvas {
            display: block !important;
            border: 1px solid black;
        }
        
        #infographicForm {
            margin: auto;
            font-size: 18px;
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
            margin-bottom: 15px;
            color: white;
            white-space: nowrap;
        }
        
        #infographicChart {
            box-sizing: border-box;
            height: 650px;
            width: 680px;
            margin: auto;
            margin-bottom: 40px;
            margin-top: 25px;
        }
        
        .fa-user-circle {
            color: white;
        }
        
        .generate-btn {
            text-align: center;
            padding: 8px 10px;
            font-size: 17px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            margin-left: 10px;
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
            <h1><a href="StaffServlet?action=showDashboard" style="text-decoration: none; color: aliceblue;">Admin Dashboard</a></h1>
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
    
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>!</h1>
        <p>If you work really hard, and you're kind, amazing things will happen.</p>
    </div>
            
    <h3>Generate Infographic</h3>
    <form id="infographicForm">
        <label>Data Type:</label>
        <select name="dataType" id="dataType">
            <option value="appointments">Monthly Appointments</option>
            <option value="appointmentByGender">Appointments by Gender</option>
            <option value="appointmentStatus">Appointment Status</option>
            <option value="assessments">Combined DASS Result</option>
            <option value="depressionLevels">Depression Only</option>
            <option value="anxietyLevels">Anxiety Only</option>
            <option value="stressLevels">Stress Only</option>
        </select>
        <label>Chart Type:</label>
        <select name="chartType" id="chartType">
            <option value="bar">Bar</option>
            <option value="pie">Pie</option>
            <option value="line">Line</option>
        </select>
        <button type="submit" class="generate-btn">Generate</button>
    </form>

    <canvas id="infographicChart" width="400" height="300"></canvas>
    
    <div>   
        <button id="exportPdfBtn" class="btn btn-danger">
            <i class="fas fa-file-pdf me-2"></i> Print
        </button>  
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
    
    <script>
        let currentChart = null;

        document.getElementById("infographicForm").addEventListener("submit", function (e) {
            e.preventDefault();

            const formData = new FormData(this);
            const dataType = formData.get("dataType");
            const chartType = formData.get("chartType");

            fetch("InfographicDataServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "dataType=" + encodeURIComponent(dataType) + "&chartType=" + encodeURIComponent(chartType)
            })
            .then(response => response.json())
            .then(data => {
                console.log("Received chart data:", data);

                const ctx = document.getElementById("infographicChart").getContext("2d");

                // Destroy old chart
                if (currentChart) {
                    currentChart.destroy();
                }

                // Render new chart
                // Register plugin
                Chart.register(ChartDataLabels);

                currentChart = new Chart(ctx, {
                    type: data.chartType,
                    data: {
                        labels: data.labels,
                        datasets: [{
                            label: data.title,
                            data: data.values,
                            backgroundColor: data.colors,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: data.title
                            },
                            legend: {
                                display: true,
                                position: 'top'
                            },
                            // ✅ Datalabels plugin configuration
                            datalabels: {
                                anchor: 'end',
                                align: 'top',
                                color: '#000',
                                font: {
                                    weight: 'bold',
                                    size: 12
                                },
                                formatter: Math.round
                            }
                        }
                    },
                    plugins: [ChartDataLabels] // ✅ Enable plugin
                }); 
            })
            .catch(error => {
                console.error("Chart render error:", error);
            });
        });
    
        // Export Chart to PDF
        document.getElementById("exportPdfBtn").addEventListener("click", function () {
            const canvas = document.getElementById("infographicChart");

            html2canvas(canvas).then((canvasObj) => {
            const imgData = canvasObj.toDataURL("image/png");
            const { jsPDF } = window.jspdf;
            const pdf = new jsPDF();
            pdf.addImage(imgData, 'PNG', 10, 10, 180, 100);

            // Open PDF in new tab instead of download
            const pdfBlob = pdf.output("blob");
            const pdfUrl = URL.createObjectURL(pdfBlob);
            window.open(pdfUrl); // opens in a new tab
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
    </body>
</html>

