<%-- 
    Document   : login
    Created on : 3 Jan 2025, 1:54:58 pm
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
    <link href="'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400&display=swap" rel="stylesheet">
    <title>MindEase - Log In</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
        }

        .left-section {
            position: relative;
            width: 50%;
            height: 100vh; /* Full height */
            background: linear-gradient(to bottom, #ffffff, #f2e9fc); /* Background gradient */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            overflow: hidden; /* Ensure content stays inside */
        }
        
        .pattern-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('image/pattern.jpg'); /* Replace with your pattern image */
            background-size: cover; /* Adjust to cover the section */
            background-repeat: no-repeat; /* No repeating */
            opacity: 0.2; /* Adjust transparency */
            z-index: 1; /* Place behind the content */
        }

        .right-section {
            flex: 1;
            background-color: #0f0e47;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            align-content: stretch;
            flex-wrap: wrap;
            flex-direction: column;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .material-icons {
            font-family: 'Material Icons';
            font-weight: normal;
            font-style: normal;
            font-size: 55px;
            line-height: 1;
            letter-spacing: normal;
            text-transform: none;
            display: inline-block;
            white-space: nowrap;
            word-wrap: normal;
            direction: ltr;
            vertical-align: bottom;
            -webkit-font-smoothing: antialiased;
        }
        
        .subtitle {
            font-size: 23px; /* Smaller font for subtitle */
            font-weight: normal; /* Makes subtitle lighter */
            margin: -27px 0 0; /* Adds spacing above and below */
            color: #000; /* Optional: A softer color */
            margin-top: 5px;
        }
        
        .quote {
            font-size: 23px; /* Smaller font for tagline */
            font-family: 'Cormorant Garamond', serif; /* Choose a hibernate-style font */
            font-style: italic; /* Optional: Italicize the text */
            margin: 35px 0 0; /* Spacing adjustments */
            color: #505081; 
        }

        .logo span {
            font-size: 14px;
            font-style: italic;
            color: #555;
        }

        .signup-container {
            width: 380px;
            padding: 20px 30px;
            background-color: #505081;
            border-radius: 15px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .signup-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
        }

        .form-group input, .form-group select {
            width: 90%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            box-shadow: 0 0 5px #5a5ae6;
        }

        .signup-container p {
            font-size: 15px;
            text-align: center;
            color: #ccc;
        }

        .signup-container button {
            width: 100%;
            padding: 10px;
            font-size: 15px;
            background-color: #272757;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .signup-container button:hover {
            background-color: #4848b4;
        }

        .link {
            text-align: center;
            margin-top: 10px;
            color: #5a5ae6;
        }

        .link a {
            text-decoration: none;
            color: #5a5ae6;
        }

        .link a:hover {
            text-decoration: underline;
        }
        
        .remember-forgot-container {
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 15px;
        }
        
        remember-me {
            margin-right: 10px; /* Add spacing between "Remember Me" and "Forgot Password" */
        }
        
        .remember-me label {
            font-size: 15px;
        }

        .forgot-password {
            color: white; /* Customize the color of the link */
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline; /* Optional hover effect */
        }
    </style>
</head>
<body>
    <div class="left-section">
        <div class="pattern-overlay"></div>
        <div class="logo">
            <h1>MINDEASE<i class="material-icons logo-icon">handshake</i></h1>
            <p class="subtitle">Counseling Appointment Management System</p>
            <p class="quote">Believe in yourself and all that you are</p>
        </div>
    </div>
    <div class="right-section"> 
        <h2>WELCOME BACK!</h2>
        <div class="signup-container">   
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="remember-forgot-container">
                    <div class="remember-me">
                        <input type="checkbox" id="remember-me">
                        <label for="remember-me">Remember Me</label>
                    </div>
                    <a href="forgotpassword.jsp" class="forgot-password">Forgot Password?</a>
                </div>
                <button type="submit">Log In</button>
            </form>
            <div style="color: darkturquoise; font-size: 16px;">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </div>
        </div>
    </div>
            
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
