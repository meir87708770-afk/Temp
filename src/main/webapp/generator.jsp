<%@ page import="java.sql.*, com.name.app.db.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String age = request.getParameter("ageGroup");
    String excuse = "";
    if (age != null) {
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM excuses WHERE age_group = ? ORDER BY RAND() LIMIT 1")) {
            ps.setString(1, age);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                excuse = rs.getString("excuse_text");
            }
        } catch(Exception e) {}
    }
%>
<html>
<head><title>מחולל התירוצים</title></head>
<body dir="rtl">
    <h2>שלום, <%= session.getAttribute("user") %></h2>
    <form method="get">
        בחר קבוצת גיל:
        <select name="ageGroup">
            <option value="0-18">0-18</option>
            <option value="18+">18+</option>
        </select>
        <button type="submit">הגרל תירוץ</button>
    </form>
    <% if(!excuse.isEmpty()) { %>
        <h3>התירוץ שלך: <%= excuse %></h3>
    <% } %>
    <br>
    <p><a href="excuses.jsp">ניהול והוספת תירוצים למאגר</a></p>
    <p><a href="login.jsp">התנתק</a></p>
</body>
</html>