<%@ page import="java.sql.*, com.name.app.db.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?")) {
            ps.setString(1, u);
            ps.setString(2, p);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                session.setAttribute("user", u);
                response.sendRedirect("generator.jsp");
                return;
            } else {
                error = "שם משתמש או סיסמה שגויים";
            }
        } catch(Exception e) {
            error = "שגיאה: " + e.getMessage();
        }
    }
%>
<html>
<head><title>התחברות</title></head>
<body dir="rtl">
    <h2>התחברות למערכת התירוצים</h2>
    <% if(!error.isEmpty()) { %> <p style="color:red;"><%= error %></p> <% } %>
    <form method="post">
        שם משתמש: <input type="text" name="username" required><br><br>
        סיסמה: <input type="password" name="password" required><br><br>
        <button type="submit">התחבר</button>
    </form>
    <p>אין לך חשבון? <a href="register.jsp">הירשם כאן</a></p>
</body>
</html>