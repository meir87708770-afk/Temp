<%@ page import="java.sql.*, com.name.app.db.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    // יוצר את הטבלאות אוטומטית אם הן לא קיימות
    try {
        DatabaseManager.initializeDatabase();
    } catch(Exception e) {
        e.printStackTrace();
    }

    response.sendRedirect("login.jsp");
%>