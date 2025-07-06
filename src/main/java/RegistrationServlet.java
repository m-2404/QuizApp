import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:xxxx/quiz_app";
    private static final String DB_USER = "db_user";
    private static final String DB_PASS = "db_password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.getWriter().println("RegistrationServlet is reachable!");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                String checkQuery = "SELECT * FROM users WHERE username = ? OR email = ?";
                try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                    psCheck.setString(1, username);
                    psCheck.setString(2, email);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) {
                            request.setAttribute("errorMessage", "Username or email already exists!");
                            request.getRequestDispatcher("Registration.jsp").forward(request, response);
                            return;
                        }
                    }
                }

                String insertQuery = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
                try (PreparedStatement psInsert = conn.prepareStatement(insertQuery)) {
                    psInsert.setString(1, username);
                    psInsert.setString(2, password);
                    psInsert.setString(3, email);
                    psInsert.executeUpdate();
                }

                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);

            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("Registration.jsp").forward(request, response);
        }
    }
}
