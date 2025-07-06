<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    //HttpSession session = request.getSession(false);
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/quiz_app";
    String dbUser = "root";
    String dbPass = "1234";

    int totalTests = 0;
    int totalScore = 0;
    String strengthArea = "N/A";
    String improvementArea = "N/A";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            // Get user ID
            String uidQuery = "SELECT user_id FROM users WHERE username = ?";
            PreparedStatement psUid = conn.prepareStatement(uidQuery);
            psUid.setString(1, username);
            ResultSet rsUid = psUid.executeQuery();
            int userId = -1;
            if (rsUid.next()) {
                userId = rsUid.getInt("user_id");
            }

            // Get test stats
            String statQuery = "SELECT t.category, t.subcategory, r.score " +
                               "FROM user_results r JOIN tests t ON r.test_id = t.test_id " +
                               "WHERE r.user_id = ?";
            PreparedStatement psStat = conn.prepareStatement(statQuery);
            psStat.setInt(1, userId);
            ResultSet rsStat = psStat.executeQuery();

            java.util.Map<String, Integer> areaScores = new java.util.HashMap<>();
            java.util.Map<String, Integer> areaCounts = new java.util.HashMap<>();

            while (rsStat.next()) {
                totalTests++;
                int score = rsStat.getInt("score");
                totalScore += score;

                String key = rsStat.getString("category") + " - " + rsStat.getString("subcategory");
                areaScores.put(key, areaScores.getOrDefault(key, 0) + score);
                areaCounts.put(key, areaCounts.getOrDefault(key, 0) + 1);
            }

            // Determine strength and improvement areas
            int maxAvg = -1, minAvg = 101;
            for (String area : areaScores.keySet()) {
                int avg = areaScores.get(area) / areaCounts.get(area);
                if (avg > maxAvg) {
                    maxAvg = avg;
                    strengthArea = area;
                }
                if (avg < minAvg) {
                    minAvg = avg;
                    improvementArea = area;
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    double accuracy = (totalTests > 0) ? (totalScore / (double)(totalTests * 100)) * 100 : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>QuizApp - Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #8e9eab, #eef2f3);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }
        .profile-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .info {
            margin: 15px 0;
        }
        .info label {
            font-weight: bold;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="profile-box">
        <h1>Welcome, <%= username %>!</h1>
        <div class="info">
            <label>Total Tests Completed:</label> <%= totalTests %>
        </div>
        <div class="info">
            <label>Overall Accuracy:</label> <%= String.format("%.2f", accuracy) %>%
        </div>
        <div class="info">
            <label>Strength Area:</label> <%= strengthArea %>
        </div>
        <div class="info">
            <label>Improvement Area:</label> <%= improvementArea %>
        </div>
        <div style="text-align:center; margin-top: 20px;">
            <a href="Welcome.jsp">🏠 Back to Home</a> |
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
</body>
</html>
