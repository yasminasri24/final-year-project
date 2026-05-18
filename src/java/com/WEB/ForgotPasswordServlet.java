/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.UserDAO;
import com.Util.EmailUtil;
import com.Util.PasswordUtil;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();

        switch (action) {
            case "sendCode":
                // Inside ForgotPasswordServlet's sendCode action
                String email = request.getParameter("email");
                if (dao.emailExists(email)) {
                    String code = String.valueOf((int)(Math.random() * 900000) + 100000);
                    session.setAttribute("resetEmail", email);  // Store the email in session
                    session.setAttribute("resetCode", code);    // Store the reset code

                    try {
                        EmailUtil.sendEmail(email, "Your Reset Code", "Use this code: " + code);
                    } catch (MessagingException e) {
                        e.printStackTrace();
                        session.setAttribute("message", "Failed to send email. Please try again.");
                        response.sendRedirect("forgotpassword.jsp");
                        return;
                    }
                    response.sendRedirect("resetcode.jsp");
                } else {
                    session.setAttribute("message", "Email not found.");
                    response.sendRedirect("forgotpassword.jsp");
                }
                break;

            case "verifyCode":
                String inputCode = request.getParameter("code");
                String sessionCode = (String) session.getAttribute("resetCode");
                if (inputCode.equals(sessionCode)) {
                    response.sendRedirect("resetpassword.jsp");
                } else {
                    session.setAttribute("message", "Invalid code.");
                    response.sendRedirect("resetcode.jsp");
                }
                break;

            case "resetPassword":
                String resetEmail = (String) session.getAttribute("resetEmail");
                if (resetEmail == null) {
                    session.setAttribute("message", "Session expired or invalid. Please restart the reset process.");
                    response.sendRedirect("forgotpassword.jsp");
                    return;
                }

                String newPassword = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");

                if (newPassword.equals(confirmPassword)) {
                    String hashed = PasswordUtil.hashPassword(newPassword);
                    dao.updatePasswordByEmail(resetEmail, hashed);  // Update the password for the email
                    session.removeAttribute("resetCode");
                    session.removeAttribute("resetEmail");

                    session.setAttribute("message", "Password successfully reset.");
                    response.sendRedirect("login.jsp");
                } else {
                    session.setAttribute("message", "Passwords do not match.");
                    response.sendRedirect("resetpassword.jsp");
                }
                break;
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
