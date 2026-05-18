/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.UserDAO;
import com.Model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class UserServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null) {
            action = "register";
        }

        switch (action) {
            case "update":
                updateUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }
    
    //Display All Users
    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("useracc-staff.jsp");
        dispatcher.forward(request, response);
    }

    //Show Edit Form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            User user = userDAO.getUserByID(userID);
            if (user != null) {
                request.setAttribute("user", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editUser-staff.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("UserServlet?action=list&error=User not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("UserServlet?action=list&error=Invalid user ID");
        }
    }
    
    //Update User
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            boolean updated = userDAO.updateUser(userID, username, email);

            if (updated) {
                request.getSession().setAttribute("message", "User updated successfully!");
                response.sendRedirect("UserServlet?action=list");
            } else {
                request.getSession().setAttribute("error", "Update failed. Please try again.");
                response.sendRedirect("editUser-staff.jsp?userID=" + userID);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid user ID format!");
            response.sendRedirect("UserServlet?action=list");
        }
    }

    //Delete User
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));

            boolean deleted = userDAO.deleteUser(userID);

            if (deleted) {
                request.getSession().setAttribute("message", "User deleted successfully!");
                response.sendRedirect("UserServlet?action=list");
            } else {
                request.getSession().setAttribute("message", "Delete failed!");
                response.sendRedirect("UserServlet?action=list");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("UserServlet?action=list&error=Invalid user ID");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
