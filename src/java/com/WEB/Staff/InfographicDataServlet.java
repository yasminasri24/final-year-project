/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB.Staff;

import com.DAO.InfographicDAO;
import com.Model.ChartResponse;
import com.Model.InfographicData;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class InfographicDataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
   
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dataType = request.getParameter("dataType");
        String chartType = request.getParameter("chartType");
        if (chartType == null || chartType.isEmpty()) {
            chartType = "bar"; // fallback chart type
        }
        
        InfographicDAO dao = new InfographicDAO();
        InfographicData data = dao.getDataForType(dataType);

        Gson gson = new Gson();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (data.getLabels() == null || data.getLabels().isEmpty()) {
            data.setTitle("No data available");
            data.setLabels(Arrays.asList("N/A"));
            data.setValues(Arrays.asList(0));
            data.setColors(Arrays.asList("#CCCCCC"));
        }

        ChartResponse chartResponse = new ChartResponse(data, chartType);
        String json = gson.toJson(chartResponse);
        response.getWriter().write(json);
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
