/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Util;

import com.Model.Appointment;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.*;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.DateTime;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;
import javax.servlet.ServletContext;

public class GoogleCalendarUtil {
 
    private static final String APPLICATION_NAME = "UMT Counseling Appointment System";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final String SERVICE_ACCOUNT_FILE = "/WEB-INF/credentials/service-account.json";
    private static final String CALENDAR_ID = Config.get("calendar.id");

    public static Calendar getCalendarService(ServletContext context) throws Exception {
        InputStream in = context.getResourceAsStream(SERVICE_ACCOUNT_FILE);

        if (in == null) {
            throw new RuntimeException("Service account file not found at " + SERVICE_ACCOUNT_FILE);
        }

        GoogleCredentials credentials = GoogleCredentials.fromStream(in)
                .createScoped(Collections.singleton("https://www.googleapis.com/auth/calendar"));

        return new Calendar.Builder(
                GoogleNetHttpTransport.newTrustedTransport(),
                JSON_FACTORY,
                new HttpCredentialsAdapter(credentials)
        ).setApplicationName(APPLICATION_NAME).build();
    }
    
    public static String createEvent(ServletContext context, String studentEmail, String counselorEmail,
                                 String title, String description,
                                 LocalDateTime start, LocalDateTime end) throws Exception {

        Calendar service = getCalendarService(context);

        Event event = new Event()
                .setSummary(title)
                .setDescription(description);

        EventDateTime startDateTime = new EventDateTime()
                .setDateTime(new com.google.api.client.util.DateTime(Date.from(start.atZone(ZoneId.systemDefault()).toInstant())))
                .setTimeZone("Asia/Kuala_Lumpur");

        EventDateTime endDateTime = new EventDateTime()
                .setDateTime(new com.google.api.client.util.DateTime(Date.from(end.atZone(ZoneId.systemDefault()).toInstant())))
                .setTimeZone("Asia/Kuala_Lumpur");

        // Add reminders
        Event.Reminders reminders = new Event.Reminders()
                .setUseDefault(false)
                .setOverrides(Arrays.asList(
                    new EventReminder().setMethod("email").setMinutes(1440),     // Email reminder 1 day before
                    new EventReminder().setMethod("email").setMinutes(120),     // Email reminder 2 hour before
                    new EventReminder().setMethod("popup").setMinutes(30)      // Popup reminder 30 minutes before
                ));
        event.setReminders(reminders);

        event.setStart(startDateTime);
        event.setEnd(endDateTime);

        Event createdEvent = service.events().insert(CALENDAR_ID, event).execute();
        return createdEvent.getId();
    }


    public static String createEvent(Appointment appointment, ServletContext context) throws Exception {
        String title = "Counseling Session";
        String description = "Appointment for: " + appointment.getCategory() + " (" + appointment.getTypeCounseling() + ")";

        LocalDateTime start = LocalDateTime.of(appointment.getDate().toLocalDate(), appointment.getTime().toLocalTime());
        LocalDateTime end = start.plusMinutes(60); // Assuming 1 hour session

        return createEvent(
            context,
            appointment.getStudentEmail(),
            appointment.getCounselorEmail(),
            title,
            description,
            start,
            end
        );
    }
    
    public static void updateEvent(ServletContext context, String eventId, String title, String description,
                               LocalDateTime start, LocalDateTime end) throws Exception {
        Calendar service = getCalendarService(context);
        Event event = service.events().get(CALENDAR_ID, eventId).execute();

        event.setSummary(title);
        event.setDescription(description);

        DateTime startDateTime = new DateTime(java.sql.Timestamp.valueOf(start));
        DateTime endDateTime = new DateTime(java.sql.Timestamp.valueOf(end));
        event.setStart(new EventDateTime().setDateTime(startDateTime).setTimeZone("Asia/Kuala_Lumpur"));
        event.setEnd(new EventDateTime().setDateTime(endDateTime).setTimeZone("Asia/Kuala_Lumpur"));

        service.events().update(CALENDAR_ID, event.getId(), event).execute();
    }
    
    public static void updateEvent(Appointment appointment, ServletContext context) throws Exception {
        String title = "Counseling Session";
        String description = "Appointment for: " + appointment.getCategory() + " (" + appointment.getTypeCounseling() + ")";

        LocalDateTime start = LocalDateTime.of(appointment.getDate().toLocalDate(), appointment.getTime().toLocalTime());
        LocalDateTime end = start.plusMinutes(60); // Assuming 1 hour session

        updateEvent(
            context,
            appointment.getEventID(),
            title,
            description,
            start,
            end
        );
    }

    public static void deleteEvent(String eventId, ServletContext context) throws Exception {
        Calendar service = getCalendarService(context);  // Assuming you have a method to get Calendar service

        try {
            // Delete the event using the eventId
            service.events().delete(CALENDAR_ID, eventId).execute();
            System.out.println("Event deleted successfully: " + eventId);
        } catch (IOException e) {
            System.err.println("Error deleting event: " + eventId);
            e.printStackTrace();
            throw new Exception("Failed to delete event from Google Calendar.");
        }
    }

}