/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Util;

import java.io.InputStream;
import java.util.Properties;
import javax.servlet.ServletContext;


public class Config {

    private static Properties props = new Properties();

    // load config file once
    public static void load(ServletContext context) {
        try (InputStream input = context.getResourceAsStream("/WEB-INF/config.properties")) {

            if (input == null) {
                throw new RuntimeException("config.properties not found in WEB-INF");
            }

            props.load(input);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // THIS IS THE IMPORTANT PART YOU ARE MISSING
    public static String get(String key) {
        return props.getProperty(key);
    }
}