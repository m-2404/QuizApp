import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:xxxx/quiz_app";
    private static final String DB_USER = "db_user";
    private static final String DB_PASS = "db_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("questions") == null) {
            response.sendRedirect("Quiz.jsp?error=Session+expired");
            return;
        }

        List<Map<String, Object>> questions = (List<Map<String, Object>>) session.getAttribute("questions");
        int score = 0;
        List<Map<String, Object>> wrongQuestions = new ArrayList<>();

        for (Map<String, Object> q : questions) {
            int qid = (int) q.get("question_id");
            int correctOption = (int) q.get("correct_option");
            String selected = request.getParameter("q_" + qid);
            
            if (selected != null) {
                int selectedOption = Integer.parseInt(selected);
                if (selectedOption == correctOption) {
                    score++;
                } else {
                    Map<String, Object> wrongQ = new HashMap<>();
                    wrongQ.put("question_text", q.get("question_text"));
                    wrongQ.put("selected_option", q.get("option" + selectedOption));
                    wrongQ.put("correct_option", q.get("option" + correctOption));
                    wrongQuestions.add(wrongQ);
                }
            } else {
                Map<String, Object> wrongQ = new HashMap<>();
                wrongQ.put("question_text", q.get("question_text"));
                wrongQ.put("selected_option", "No Answer");
                wrongQ.put("correct_option", q.get("option" + correctOption));
                wrongQuestions.add(wrongQ);
            }
        }

        // Save result (optional)
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            Integer userId = (Integer) session.getAttribute("user_id");
            Integer testId = (Integer) session.getAttribute("test_id");
            if (userId != null && testId != null) {
                String sql = "INSERT INTO user_results (user_id, test_id, score) VALUES (?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, testId);
                    ps.setInt(3, score);
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("score", score);
        request.setAttribute("total", questions.size());
        request.setAttribute("wrongQuestions", wrongQuestions);
        request.getRequestDispatcher("Result.jsp").forward(request, response);
    }
}
