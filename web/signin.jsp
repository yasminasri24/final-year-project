<%-- 
    Document   : signin
    Created on : 15 Jan 2025, 3:47:31 am
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
    <title>MindEase - Sign Up</title>
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
            width: 320px;
            padding: 20px;
            background-color: #505081;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
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
            font-size: 14px;
        }

        .form-group input, .form-group select {
            width: 90%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            box-shadow: 0 0 5px #5a5ae6;
        }
        
        .input-group {
            display: flex;
            align-items: center;
            background-color: #eee;
            border-radius: 5px;
            padding: 5px;
            margin-bottom: 15px;
        }

        .input-group .icon {
            margin: 0 10px;
            color: gray;
        }

        .input-group input {
            flex: 1;
            border: none;
            background: none;
            padding: 10px;
            font-size: 14px;
            outline: none;
        }

        .signup-container p {
            font-size: 15px;
            text-align: center;
            color: white;
        }

        .signup-container button {
            width: 100%;
            padding: 10px;
            font-size: 14px;
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
            color: cyan;
        }

        .link a {
            text-decoration: none;
            color: cyan;
        }

        .link a:hover {
            text-decoration: underline;
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
    <h1>SIGN UP</h1>
    <div class="signup-container">
        <form action="RegisterServlet" method="post" id="signupForm">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-group">
                    <input type="text" id="username" name="username" required />
                    <i class="fa fa-user icon"></i>
                </div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <input type="password" id="password" name="password" required />
                    <i class="fa fa-eye icon" id="togglePassword" onclick="togglePassword('password', 'togglePassword')" style="display: none; cursor: pointer;"></i>
                </div>
                <p id="passwordPolicyError" style="color: red; font-size: 14px; display: none; margin-top: 4px;">
                    Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.
                </p>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-group">
                    <input type="password" id="confirmPassword" name="confirmPassword" required />
                    <i class="fa fa-eye icon" id="toggleConfirmPassword" onclick="togglePassword('confirmPassword', 'toggleConfirmPassword')" style="display: none; cursor: pointer;"></i>
                </div>
                <p id="passwordError" style="color: darkturquoise; font-size: 16px; display: none;">Passwords do not match!</p>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <div class="input-group">
                    <input type="email" id="email" name="email" required>
                    <i class="fa fa-envelope icon"></i>
                </div>
            </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select id="roleSelect" name="role" required onchange="showRoleSpecificFields()">
                    <option value="">Select Role</option>
                    <option value="student">Student</option>
                    <option value="counselor">Counselor</option>
                    <option value="staff">HEPA Staff</option>
                </select>
            </div>
            
            <!-- Role-Specific Fields -->
            <!-- Student Role -->
            <div id="studentFields" style="display:none;">
                <div class="form-group">
                    <label for="studentname">Student Name</label>
                    <input type="text" id="studentname" name="studentname" />
                </div>
                <div class="form-group">
                    <label for="program">Program</label>
                    <input type="text" id="program" name="program" />
                </div>
                <div class="form-group">
                    <label for="year">Year</label>
                    <input type="number" id="year" name="year" />
                </div>
                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender">
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="phoneS">Phone</label>
                    <input type="text" id="phoneS" name="phoneS" />
                </div>
            </div>
            
            <!-- Counselor Role -->
            <div id="counselorFields" style="display:none;">
                <div class="form-group">
                    <label for="counselorname">Counselor Name</label>
                    <input type="text" id="counselorname" name="counselorname" />
                </div>
                <div class="form-group">
                    <label for="specialization">Specialization</label>
                    <input type="text" id="specialization" name="specialization" />
                </div>
                <div class="form-group">
                    <label for="phoneC">Phone</label>
                    <input type="text" id="phoneC" name="phoneC" />
                </div>
            </div>
            
            <!-- Staff Role -->
            <div id="staffFields" style="display:none;">
                <div class="form-group">
                    <label for="staffname">Staff Name</label>
                    <input type="text" id="staffname" name="staffname" />
                </div>
                <div class="form-group">
                    <label for="departmentS">Department</label>
                    <input type="text" id="departmentS" name="departmentS" />
                </div>
            </div>
            
            <p>By signing up, you agree to our Terms of Service and Privacy Policy</p>
            <button type="submit">Sign In</button>
        </form>
        
        <div class="link">
            <p>Already have an account? <a href="login.jsp">Log in here</a>.</p>
        </div>
    </div>
    </div>
    
    <script>
    window.onload = function () {
        const passwordField = document.getElementById("password");
        const confirmPasswordField = document.getElementById("confirmPassword");
        const togglePasswordIcon = document.getElementById("togglePassword");
        const toggleConfirmIcon = document.getElementById("toggleConfirmPassword");
        const passwordError = document.getElementById("passwordError");
        const policyError = document.getElementById("passwordPolicyError");
        const signupForm = document.getElementById("signupForm");

        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])[A-Za-z\d@$!%*?&_.#-]{8,}$/;

        // Show eye icons
        passwordField.addEventListener("focus", () => {
            togglePasswordIcon.style.display = "inline";
            policyError.style.display = "none"; // hide error on click
        });

        confirmPasswordField.addEventListener("focus", () => {
            toggleConfirmIcon.style.display = "inline";
            passwordError.style.display = "none"; // optional: hide confirm error on focus
        });

        // Password blur - validate policy
        passwordField.addEventListener("blur", function () {
            if (!passwordRegex.test(passwordField.value)) {
                policyError.style.display = "block";
            } else {
                policyError.style.display = "none";
            }
        });

        // While typing - hide error if valid
        passwordField.addEventListener("input", function () {
            if (passwordRegex.test(passwordField.value)) {
                policyError.style.display = "none";
            }
        });

        // Confirm password blur
        confirmPasswordField.addEventListener("blur", function () {
            if (passwordField.value !== confirmPasswordField.value) {
                passwordError.style.display = "block";
            } else {
                passwordError.style.display = "none";
            }
        });

        // Form submission check
        signupForm.addEventListener("submit", function (event) {
            let isValid = true;

            if (!passwordRegex.test(passwordField.value)) {
                policyError.style.display = "block";
                isValid = false;
            }

            if (passwordField.value !== confirmPasswordField.value) {
                passwordError.style.display = "block";
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();
            }
        });
    };

    function togglePassword(inputId, iconId) {
        const field = document.getElementById(inputId);
        const icon = document.getElementById(iconId);

        if (field.type === "password") {
            field.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            field.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>

    <script>
        function showRoleSpecificFields() {
            document.getElementById("studentFields").style.display = "none";
            document.getElementById("counselorFields").style.display = "none";
            document.getElementById("staffFields").style.display = "none";
            if (document.getElementById("roleSelect").value === "student") {
                document.getElementById("studentFields").style.display = "block";
            } else if (document.getElementById("roleSelect").value === "counselor") {
                document.getElementById("counselorFields").style.display = "block";
            } else if (document.getElementById("roleSelect").value === "staff") {
                document.getElementById("staffFields").style.display = "block";
            }
        }
    </script>

    <script type="text/javascript">
        // Show alert from session message
        <c:if test="${not empty sessionScope.message}">
            alert("${sessionScope.message}");
        </c:if>
    </script>

    <%
        // Clear session message
        session.removeAttribute("message");
    %>

</body>
</html>
