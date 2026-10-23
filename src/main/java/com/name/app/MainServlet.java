import com.name.app.db.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/action")
public class MainServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try (Connection conn = DatabaseManager.getConnection()) {
            if ("register".equals(action)) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)");
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ps.executeUpdate();
                response.sendRedirect(request.getContextPath() + "/page?view=login");

            } else if ("login".equals(action)) {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.getSession().setAttribute("user", request.getParameter("username"));
                    response.sendRedirect(request.getContextPath() + "/page?view=generator");
                } else {
                    response.sendRedirect(request.getContextPath() + "/page?view=login&error=1");
                }

            } else if ("add".equals(action)) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO excuses (excuse_text, age_group) VALUES (?, ?)");
                ps.setString(1, request.getParameter("excuseText"));
                ps.setString(2, request.getParameter("ageGroup"));
                ps.executeUpdate();
                response.sendRedirect(request.getContextPath() + "/page?view=excuses");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}