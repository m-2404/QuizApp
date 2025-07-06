import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quiz_app";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String testIdStr = request.getParameter("test_id");
        if (testIdStr == null) {
            response.sendRedirect("Quiz.jsp?error=Missing+test+ID");
            return;
        }

        int testId;
        try {
            testId = Integer.parseInt(testIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("Quiz.jsp?error=Invalid+test+ID");
            return;
        }

        List<Map<String, Object>> questions = new ArrayList<>();
        int timeLimitSeconds = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                
                // Get time limit
                String testSql = "SELECT time_limit FROM tests WHERE test_id = ?";
                try (PreparedStatement psTest = conn.prepareStatement(testSql)) {
                    psTest.setInt(1, testId);
                    ResultSet rsTest = psTest.executeQuery();
                    if (rsTest.next()) {
                        timeLimitSeconds = rsTest.getInt("time_limit");
                    } else {
                        response.sendRedirect("Quiz.jsp?error=Test+not+found");
                        return;
                    }
                }

                // Get questions
                String qSql = "SELECT * FROM questions WHERE test_id = ?";
                try (PreparedStatement psQ = conn.prepareStatement(qSql)) {
                    psQ.setInt(1, testId);
                    ResultSet rsQ = psQ.executeQuery();

                    while (rsQ.next()) {
                        Map<String, Object> q = new HashMap<>();
                        q.put("question_id", rsQ.getInt("question_id"));
                        q.put("question_text", rsQ.getString("question_text"));
                        q.put("option1", rsQ.getString("option1"));
                        q.put("option2", rsQ.getString("option2"));
                        q.put("option3", rsQ.getString("option3"));
                        q.put("option4", rsQ.getString("option4"));
                        q.put("correct_option", rsQ.getInt("correct_option"));  // ✅ ADD THIS LINE
                        questions.add(q);
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Quiz.jsp?error=DB+Error");
            return;
        }

        if (questions.isEmpty()) {
            response.sendRedirect("Quiz.jsp?error=No+questions+found+for+this+test");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("questions", questions);
        session.setAttribute("test_id", testId);
        session.setAttribute("time_limit", timeLimitSeconds);
        session.setAttribute("start_time", System.currentTimeMillis());

        request.getRequestDispatcher("Test.jsp").forward(request, response);
    }
}
