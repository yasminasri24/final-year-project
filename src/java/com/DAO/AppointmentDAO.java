/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import java.sql.*;
import com.Model.Appointment;
import com.Model.Counselor; 
import com.Model.Student;
import com.Util.DBConnection; 
import com.Util.GoogleCalendarUtil;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

public class AppointmentDAO {
    
    //insert appointment into database
    public void insertAppointment(Appointment appointment, ServletContext context) throws Exception {
        // 1. Create calendar event
        LocalDateTime start = LocalDateTime.of(appointment.getDate().toLocalDate(), appointment.getTime().toLocalTime());
        LocalDateTime end = start.plusMinutes(30); // or 1 hour

        String eventId = GoogleCalendarUtil.createEvent(appointment, context);

        // 2. Insert into DB with eventId
        String sql = "INSERT INTO appointment (studentID, counselorID, date, time, category, typeCounseling, groupMembers, status, eventID) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, appointment.getStudentID());
            stmt.setInt(2, appointment.getCounselorID());
            stmt.setDate(3, appointment.getDate());
            stmt.setTime(4, appointment.getTime());
            stmt.setString(5, appointment.getCategory());
            stmt.setString(6, appointment.getTypeCounseling());
            stmt.setString(7, appointment.getGroupMembers());
            stmt.setString(8, appointment.getStatus());
            stmt.setString(9, eventId); // Store event ID

            stmt.executeUpdate();
        }
    }
    
    
    //auto-assign counselor
    public Counselor autoAssignCounselor(Date date, Time time) throws SQLException {
        String sql = "SELECT c.counselorID, c.counselorname, c.specialization, c.phoneC, COUNT(a.appointmentID) AS appointmentCount " +
                     "FROM counselor c " +
                     "LEFT JOIN appointment a ON c.counselorID = a.counselorID AND a.date = ? AND a.time = ? " +
                     "GROUP BY c.counselorID " +
                     "ORDER BY appointmentCount ASC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setTime(2, time);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Counselor counselor = new Counselor();
                counselor.setCounselorID(rs.getInt("counselorID"));
                counselor.setCounselorname(rs.getString("counselorname"));
                counselor.setSpecialization(rs.getString("specialization"));
                counselor.setPhoneC(rs.getString("phoneC"));
                return counselor;
            }
        }
        return null; // no counselor found
    }
    
    //Get available time slots for a given date
    public List<Time> getAvailableTimeSlots(java.sql.Date date) throws SQLException {
        List<Time> availableSlots = new ArrayList<>();

        // Define working hours (e.g. 9 AM to 5 PM, every hour)
        LocalTime start = LocalTime.of(9, 0);
        LocalTime end = LocalTime.of(17, 0);

        // Build list of times to check
        while (!start.isAfter(end.minusHours(1))) {
            availableSlots.add(Time.valueOf(start));
            start = start.plusHours(1);
        }

        String sql = "SELECT time FROM appointment WHERE date = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Time booked = rs.getTime("time");
                availableSlots.remove(booked); // Remove already booked times
            }
        }

        return availableSlots;
    }
    

    //get Counselor details
    public Counselor getCounselorDetails(int counselorID) throws SQLException {
        String sql = "SELECT * FROM counselor WHERE counselorID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Counselor counselor = new Counselor();
                counselor.setCounselorID(rs.getInt("counselorID"));
                counselor.setCounselorname(rs.getString("counselorname"));
                counselor.setPhoneC(rs.getString("phoneC"));
                counselor.setSpecialization(rs.getString("specialization"));
                return counselor;
            } else {
                return null;
            }
        }
    }
      
    public Student getStudentDetails(int studentID) throws SQLException {
        String sql = "SELECT * FROM student WHERE studentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setStudentID(rs.getInt("studentID"));
                    student.setStudentName(rs.getString("studentname"));
                    student.setPhoneS(rs.getString("phoneS"));
                    return student;
                }
            }
        }
        return null;
    }
    
    
    //Get the Upcoming Appointment for Student Dashboard
    public Appointment getUpcomingAppointment(int studentID) {
        System.out.println("Fetching upcoming appointment for studentID: " + studentID);
        
        Appointment appointment = null;
        String sql = "SELECT a.*, c.counselorname, c.phoneC " +
                 "FROM appointment a " +
                 "JOIN counselor c ON a.counselorID = c.counselorID " +
                 "WHERE a.studentID = ? AND a.status = 'Confirmed' " +
                 "AND (a.date > CURDATE() OR (a.date = CURDATE() AND a.time > CURTIME())) " +
                 "ORDER BY a.date ASC, a.time ASC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("Debug: Appointment found - ID: " + rs.getInt("appointmentID"));

                appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("appointmentID"));
                appointment.setTypeCounseling(rs.getString("typeCounseling"));
                appointment.setCategory(rs.getString("category"));
                appointment.setDate(rs.getDate("date"));
                appointment.setTime(rs.getTime("time"));
                appointment.setCounselorID(rs.getInt("counselorID"));
                appointment.setStatus(rs.getString("status"));

                // Add counselor info to appointment
                Counselor counselor = new Counselor();
                counselor.setCounselorname(rs.getString("counselorname"));
                counselor.setPhoneC(rs.getString("phoneC"));
                appointment.setCounselor(counselor);
            } else {
            System.out.println("Debug: No upcoming appointment found.");
        }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointment;
    }
    
    
    public Appointment getAppointmentsByID(int appointmentID) {
        Appointment appointment = null;
        String sql = "SELECT * FROM appointment WHERE appointmentID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("appointmentID"));
                appointment.setStudentID(rs.getInt("studentID"));
                appointment.setCounselorID(rs.getInt("counselorID"));
                appointment.setDate(rs.getDate("date"));
                appointment.setTime(rs.getTime("time"));
                appointment.setCategory(rs.getString("category"));
                appointment.setTypeCounseling(rs.getString("typeCounseling"));
                appointment.setGroupMembers(rs.getString("groupMembers"));
                appointment.setStatus(rs.getString("status"));
                appointment.setEventID(rs.getString("eventID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointment;
    }

    
    //View all appointments for student history
    public List<Appointment> getAppointmentsByStudent(int studentID) {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, c.counselorname, c.phoneC FROM appointment a " +
                     "JOIN counselor c ON a.counselorID = c.counselorID " +
                     "WHERE a.studentID = ? ORDER BY a.date DESC, a.time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentID(rs.getInt("appointmentID"));
                a.setStudentID(rs.getInt("studentID"));
                a.setCounselorID(rs.getInt("counselorID"));
                a.setDate(rs.getDate("date"));
                a.setTime(rs.getTime("time"));
                a.setCategory(rs.getString("category"));
                a.setTypeCounseling(rs.getString("typeCounseling"));
                a.setStatus(rs.getString("status"));

                Counselor c = new Counselor();
                c.setCounselorname(rs.getString("counselorname"));
                c.setPhoneC(rs.getString("phoneC"));
                a.setCounselor(c);
                
                // Check if feedback has been submitted for this appointment
                boolean isSubmitted = feedbackDAO.isFeedbackSubmitted(a.getAppointmentID());
                a.setFeedbackSubmitted(isSubmitted);

                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    //Update appointment details
    public boolean updateAppointment(Appointment appointment, ServletContext context) throws Exception {
        // Step 1: Reassign if current counselor is unavailable
        if (!isCounselorAvailable(appointment.getCounselorID(), appointment.getDate(), appointment.getTime())) {
            Counselor newCounselor = autoAssignCounselor(appointment.getDate(), appointment.getTime());
            if (newCounselor == null) {
                throw new Exception("No available counselor found for the updated time.");
            }
            appointment.setCounselorID(newCounselor.getCounselorID());
        }

        // Step 2: Update DB
        String sql = "UPDATE appointment SET typeCounseling=?, category=?, groupMembers=?, date=?, time=?, counselorID=? WHERE appointmentID=?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, appointment.getTypeCounseling());
            ps.setString(2, appointment.getCategory());
            ps.setString(3, appointment.getGroupMembers());
            ps.setDate(4, appointment.getDate());
            ps.setTime(5, appointment.getTime());
            ps.setInt(6, appointment.getCounselorID());
            ps.setInt(7, appointment.getAppointmentID());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                GoogleCalendarUtil.updateEvent(appointment, context);
                return true;
            }
        }
        return false;
    }
    
    public boolean isCounselorAvailable(int counselorID, Date date, Time time) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointment WHERE counselorID = ? AND date = ? AND time = ?";

        try (Connection conn = DBConnection.getConnection(); 
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, counselorID);
            ps.setDate(2, date);
            ps.setTime(3, time);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Available if no appointment found
                }
            }
        }
        return false;
    }

       
    //Delete or cancel the appointment
    public boolean deleteAppointment(int appointmentID, ServletContext context) {
        String eventId = null;
        String sql = "SELECT eventID FROM appointment WHERE appointmentID = ?";

        // Retrieve eventID from DB
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                eventId = rs.getString("eventID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // If eventId exists, delete from Google Calendar
        if (eventId != null) {
            try {
                GoogleCalendarUtil.deleteEvent(eventId, context);  // Call to delete the event
            } catch (Exception e) {
                e.printStackTrace();
                return false; // Return false if deletion fails
            }
        }

        // Now delete the appointment from DB
        String deleteSQL = "DELETE FROM appointment WHERE appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(deleteSQL)) {
            ps.setInt(1, appointmentID);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    //View all the appointments for staff pov
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, s.studentname, s.phoneS, c.counselorname " +
                     "FROM appointment a " +
                     "JOIN student s ON a.studentID = s.studentID " +
                     "JOIN counselor c ON a.counselorID = c.counselorID " +
                     "ORDER BY a.date DESC, a.time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentID(rs.getInt("appointmentID"));
                a.setStudentID(rs.getInt("studentID"));
                a.setCounselorID(rs.getInt("counselorID"));
                a.setDate(rs.getDate("date"));
                a.setTime(rs.getTime("time"));
                a.setCategory(rs.getString("category"));
                a.setTypeCounseling(rs.getString("typeCounseling"));
                a.setStatus(rs.getString("status"));

                Student s = new Student();
                s.setStudentName(rs.getString("studentname"));
                s.setPhoneS(rs.getString("phoneS"));
                a.setStudent(s);

                Counselor c = new Counselor();
                c.setCounselorname(rs.getString("counselorname"));
                a.setCounselor(c);

                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    //Counselor Part
    public List<Appointment> getPendingAppointments(int counselorID) {
        List<Appointment> appointments = new ArrayList<>();

        String sql = "SELECT a.*, s.studentname " +
                     "FROM appointment a " +
                     "JOIN student s ON a.studentID = s.studentID " +
                     "WHERE a.counselorID = ? AND a.status = 'Pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, counselorID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getInt("appointmentID"));
                appt.setStudentID(rs.getInt("studentID"));
                appt.setTypeCounseling(rs.getString("typeCounseling"));
                appt.setCategory(rs.getString("category"));
                appt.setDate(rs.getDate("date"));
                appt.setTime(rs.getTime("time"));
                appt.setStatus(rs.getString("status"));
                appt.setStudentname(rs.getString("studentname"));  // You must have this in your model

                appointments.add(appt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointments;
    }
    
    
    //Get Today Appointment
    public List<Appointment> getTodaysAppointments(int counselorId) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();

        String sql = "SELECT a.*, s.studentname " +
                 "FROM appointment a " +
                 "JOIN student s ON a.studentID = s.studentID " +
                 "WHERE a.counselorID = ? AND DATE(a.date) = CURDATE() AND a.status = 'Confirmed'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
            Appointment appt = new Appointment();
            appt.setAppointmentID(rs.getInt("appointmentID"));
            appt.setStudentID(rs.getInt("studentID"));
            appt.setDate(rs.getDate("date"));
            appt.setTime(rs.getTime("time"));
            appt.setTypeCounseling(rs.getString("typeCounseling"));
            appt.setCategory(rs.getString("category"));
            appt.setStatus(rs.getString("status"));
            appt.setStudentname(rs.getString("studentname")); // Set from JOIN

            appointments.add(appt);
            }
        }

        return appointments;
    }

    
    //Update appointment status
    public boolean updateAppointmentStatus(int appointmentID, String status) {
        String sql = "UPDATE appointment SET status = ? WHERE appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, appointmentID);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    //Get appointments for a Counselor
    public List<Appointment> getConfirmedAppointmentsByCounselorId(int counselorID) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, s.studentname FROM appointment a " +
                     "JOIN student s ON a.studentID = s.studentID " +
                     "WHERE a.counselorID = ? AND a.status IN ('Confirmed', 'Completed') " +
                     "ORDER BY a.date, a.time";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, counselorID);
                ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentID(rs.getInt("appointmentID"));
                a.setStudentID(rs.getInt("studentID"));
                a.setStudentname(rs.getString("studentname"));
                a.setDate(rs.getDate("date"));
                a.setTime(rs.getTime("time"));
                a.setTypeCounseling(rs.getString("typeCounseling"));
                a.setCategory(rs.getString("category"));
                a.setStatus(rs.getString("status"));
                appointments.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }
    
    
    //Filter by name
    public List<Appointment> getFilteredAppointments(int counselorID, String search, String status) {
        List<Appointment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT a.*, s.studentname FROM appointment a JOIN student s ON a.studentID = s.studentID WHERE a.counselorID = ?"
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND s.studentname LIKE ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ?");
        }

        sql.append(" ORDER BY date DESC, time DESC"); // ✅ move this to the end

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int i = 1;
            stmt.setInt(i++, counselorID);
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(i++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                stmt.setString(i++, status);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getInt("appointmentID"));
                appt.setStudentname(rs.getString("studentname"));
                appt.setStudentID(rs.getInt("studentID"));
                appt.setDate(rs.getDate("date"));
                appt.setTime(rs.getTime("time"));
                appt.setTypeCounseling(rs.getString("typeCounseling"));
                appt.setCategory(rs.getString("category"));
                appt.setStatus(rs.getString("status"));
                appt.setNotes(rs.getString("notes"));
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    //Update Appointment Notes
    public boolean updateAppointmentNotes(int appointmentID, String notes) {
        String sql = "UPDATE appointment SET notes = ? WHERE appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, notes);
            stmt.setInt(2, appointmentID);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Appointment getAppointmentByID(int appointmentID) {
        String sql = "SELECT a.*, s.studentname FROM appointment a JOIN student s ON a.studentID = s.studentID WHERE a.appointmentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getInt("appointmentID"));
                appt.setStudentID(rs.getInt("studentID"));
                appt.setDate(rs.getDate("date"));
                appt.setTime(rs.getTime("time"));
                appt.setTypeCounseling(rs.getString("typeCounseling"));
                appt.setCategory(rs.getString("category"));
                appt.setStatus(rs.getString("status"));
                appt.setStudentname(rs.getString("studentname"));
                appt.setNotes(rs.getString("notes"));
                return appt;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static Appointment getAppointmentById(int appointmentID) {
        Appointment appt = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM appointment WHERE appointmentID = ?")) {

            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                appt = new Appointment();
                appt.setAppointmentID(rs.getInt("appointmentID"));
                appt.setDate(rs.getDate("date"));
                appt.setTime(rs.getTime("time"));
                appt.setTypeCounseling(rs.getString("typeCounseling"));
                appt.setCategory(rs.getString("category"));
                // Add other fields as needed
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appt;
    }
    
    public int countAppointmentsByStatus(int counselorID, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointment WHERE counselorID = ? AND status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorID);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int countAppointmentsByCategory(int counselorID, String category) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointment WHERE counselorID = ? AND category = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, counselorID);
            stmt.setString(2, category);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    public List<Appointment> getAppointmentsByStatus(String status) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, s.studentname, s.phoneS, c.counselorname " +
                     "FROM appointment a " +
                     "JOIN student s ON a.studentID = s.studentID " +
                     "JOIN counselor c ON a.counselorID = c.counselorID " +
                     "WHERE a.status = ? " +
                     "ORDER BY a.date DESC, a.time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentID(rs.getInt("appointmentID"));
                a.setStudentID(rs.getInt("studentID"));
                a.setCounselorID(rs.getInt("counselorID"));
                a.setDate(rs.getDate("date"));
                a.setTime(rs.getTime("time"));
                a.setCategory(rs.getString("category"));
                a.setTypeCounseling(rs.getString("typeCounseling"));
                a.setStatus(rs.getString("status"));

                Student s = new Student();
                s.setStudentName(rs.getString("studentname"));
                s.setPhoneS(rs.getString("phoneS"));
                a.setStudent(s);

                Counselor c = new Counselor();
                c.setCounselorname(rs.getString("counselorname"));
                a.setCounselor(c);

                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }  
}