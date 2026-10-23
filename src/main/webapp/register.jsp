<%@ page import="java.sql.*, com.name.app.db.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String msg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)")) {
            ps.setString(1, u);
            ps.setString(2, p);
            ps.executeUpdate();
            response.sendRedirect("login.jsp");
            return;
        } catch(Exception e) {
            msg = "שגיאה בהרשמה: " + e.getMessage();
        }
    }
%>
<html>
<head><title>הרשמה</title></head>
<body dir="rtl">
    <h2>הרשמה למערכת</h2>
    <% if(!msg.isEmpty()) { %> <p style="color:red;"><%= msg %></p> <% } %>
    <form method="post">
        שם משתמש: <input type="text" name="username" required><br><br>
        סיסמה: <input type="password" name="password" required><br><br>
        <button type="submit">הירשם</button>
    </form>
    <p>יש לך חשבון? <a href="login.jsp">התחבר כאן</a></p>
</body>
</html>