<%-- 
    Document   : forgotpassword
    Created on : 1 Jul 2025, 1:50:51 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <title>MINDEASE - Forgot Password</title>
    </head>
    <body class="bg-light">
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 400px;">
            <div class="card-body">
                <h4 class="card-title text-center mb-4">Forgot Password</h4>

                <% String message = (String) session.getAttribute("message");
                   if (message != null) { %>
                    <div class="alert alert-warning text-center"><%= message %></div>
                    <% session.removeAttribute("message"); %>
                <% } %>

                <form action="ForgotPasswordServlet" method="post">
                    <input type="hidden" name="action" value="sendCode">
                    <div class="mb-3">
                        <label for="email" class="form-label">Enter your email address</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Send Code</button>
                </form>
            </div>
        </div>
    </div>
    </body>
</html>
