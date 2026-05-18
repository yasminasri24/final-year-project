<%-- 
    Document   : RegistrationResult
    Created on : 15 Jan 2025, 4:01:31 am
    Author     : DELL
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration Result</title>
    <script type="text/javascript">
        window.onload = function() {
            var message = "<%= request.getAttribute("message") %>";
            var redirectPage = "<%= request.getAttribute("redirectPage") %>";

            // Show the pop-up message
            alert(message);

            // Redirect after the pop-up is closed
            setTimeout(function() {
                window.location.href = redirectPage;
            }, 2000); // Delay of 2 seconds before redirect
        }
    </script>
</head>
<body>
</body>
</html>
