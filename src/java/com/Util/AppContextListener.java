/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println(">>> APP STARTED - CONTEXT LISTENER RUNNING");

        Config.load(sce.getServletContext());

        System.out.println(">>> CONFIG LOADED");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // optional
    }
}
