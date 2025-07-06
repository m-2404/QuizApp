import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

    public class MySqlConnect {
        public static void main(String[] args) {
            // Replace values below with your actual MySQL info
            String url = "jdbc:mysql://localhost:xxxx/quiz_app";
            String username = "db_user";
            String password = "db_password";

            try {
                Connection conn = DriverManager.getConnection(url, username, password);
                System.out.println("✅ Connected successfully to MySQL database!");
                conn.close();
            } catch (SQLException e) {
                System.out.println("❌ Connection failed: " + e.getMessage());
            }
        }
    }


