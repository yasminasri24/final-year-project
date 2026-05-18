/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Util;

import com.Model.Appointment;
import com.Model.Student;
import com.Model.Counselor;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.OutputStream;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletContext;

public class ReferralPDFGenerator {
    
    public static void generate(OutputStream out, Student student, Counselor counselor, Appointment appointment,
                                String referralTo, String reason, String notes, ServletContext context) throws Exception {
        Document document = new Document();
        PdfWriter.getInstance(document, out);
        document.open();
        
        // Add UMT logo
        try {
            String imagePath = context.getRealPath("/image/logoUMT.png");
            Image logo = Image.getInstance(imagePath);
            logo.scaleToFit(100, 100);
            logo.setAlignment(Image.ALIGN_CENTER);
            document.add(logo);
        } catch (Exception e) {
            document.add(new Paragraph("UMT Logo could not be loaded."));
        }

        
        // Header letter
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Paragraph header = new Paragraph("Universiti Malaysia Terengganu (UMT)\nCounseling Referral Letter", headerFont);
        header.setAlignment(Element.ALIGN_CENTER);
        document.add(header);

        document.add(new Paragraph(" ")); // Space


        // Add date
        Font normal = new Font(Font.FontFamily.HELVETICA, 12);
        document.add(new Paragraph("Date: " + new java.text.SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date()), normal));
        document.add(new Paragraph(" "));

        // Referral Details
        document.add(new Paragraph("To: " + referralTo, normal));
        document.add(new Paragraph(" "));

        document.add(new Paragraph("Student Name: " + student.getStudentName(), normal));
        document.add(new Paragraph("Student ID: " + student.getStudentID(), normal));

        // Format appointment date from java.util.Date
        java.util.Date originalDate = appointment.getDate(); // assuming this returns java.util.Date or java.sql.Date
        String formattedDate = new java.text.SimpleDateFormat("dd-MM-yyyy").format(originalDate);

        document.add(new Paragraph("Appointment Date: " + formattedDate, normal));
        document.add(new Paragraph("Appointment Time: " + appointment.getTime(), normal));
        document.add(new Paragraph("Counselor: " + counselor.getCounselorname(), normal));
        document.add(new Paragraph("Specialization: " + counselor.getSpecialization(), normal));
        document.add(new Paragraph(" "));

        document.add(new Paragraph("Reason for Referral:", normal));
        document.add(new Paragraph(reason, normal));
        document.add(new Paragraph(" "));

        if (notes != null && !notes.trim().isEmpty()) {
            document.add(new Paragraph("Additional Notes:", normal));
            document.add(new Paragraph(notes, normal));
        }

        document.close();
    }
}