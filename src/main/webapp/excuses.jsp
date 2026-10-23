<%@ page import="java.sql.*, com.name.app.db.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String text = request.getParameter("excuseText");
        String age = request.getParameter("ageGroup");
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO excuses (excuse_text, age_group) VALUES (?, ?)")) {
            ps.setString(1, text);
            ps.setString(2, age);
            ps.executeUpdate();
        } catch(Exception e) {}
    }
%>
<html>
<head><title>ניהול תירוצים</title></head>
<body dir="rtl">
    <h2>הוספת תירוץ חדש למאגר</h2>
    <form method="post">
        תירוץ: <input type="text" name="excuseText" required style="width: 300px;">
        קבוצת גיל:
        <select name="ageGroup">
            <option value="0-18">0-18</option>
            <option value="18+">18+</option>
        </select>
        <button type="submit">הוסף תירוץ</button>
    </form>

    <h2>רשימת התירוצים הקיימים במאגר</h2>
    <ul>
        <%
            try (Connection conn = DatabaseManager.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM excuses")) {
                while(rs.next()) {
        %>
            <li>[<strong><%= rs.getString("age_group") %></strong>] <%= rs.getString("excuse_text") %></li>
        <%
                }
            } catch(Exception e) {}
        %>
    </ul>
    <p><a href="generator.jsp">חזרה למחולל התירוצים</a></p>
</body>
</html>