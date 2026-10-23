package com.name.app.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseManager {
    private static boolean initialized = false;

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = DriverManager.getConnection("jdbc:h2:~/excuses_db;MODE=PostgreSQL;DATABASE_TO_UPPER=FALSE;AUTO_SERVER=TRUE", "sa", "");

        // יוצר את הטבלאות אוטומטית בחיבור הראשון אם הן לא קיימות
        if (!initialized) {
            try (Statement stmt = conn.createStatement()) {
                stmt.execute("CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), password VARCHAR(50))");
                stmt.execute("CREATE TABLE IF NOT EXISTS excuses (id INT AUTO_INCREMENT PRIMARY KEY, excuse_text VARCHAR(255), age_group VARCHAR(10))");
                initialized = true;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return conn;
    }
}