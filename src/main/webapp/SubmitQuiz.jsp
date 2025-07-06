<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" %>
<%
int testId = Integer.parseInt(request.getParameter("test_id"));
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

int score = 0;
int total = 0;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:xxxx/quiz_app", "db_user", "db_password");

    // Fetch user id
    ps = conn.prepareStatement("SELECT user_id FROM users WHERE username = ?");
    ps.setString(1, username);
    rs = ps.executeQuery();
    int userId = 0;
    if (rs.next()) {
        userId = rs.getInt(1);
    }
    rs.close();
    ps.close();

    // Fetch questions + correct answers
    ps = conn.prepareStatement("SELECT question_id, correct_option FROM questions WHERE test_id = ?");
    ps.setInt(1, testId);
    rs = ps.executeQuery();
    while (rs.next()) {
        total++;
        int qid = rs.getInt("question_id");
        int correct = rs.getInt("correct_option");
        String ans = request.getParameter("q_" + qid);
        if (ans != null && Integer.parseInt(ans) == correct) {
            score++;
        }
    }
    rs.close();
    ps.close();

    // Save result
    ps = conn.prepareStatement("INSERT INTO user_results (user_id, test_id, score) VALUES (?, ?, ?)");
    ps.setInt(1, userId);
    ps.setInt(2, testId);
    ps.setInt(3, score);
    ps.executeUpdate();
    ps.close();
%>
<jsp:forward page="Result.jsp">
    <jsp:param name="score" value="<%= score %>" />
    <jsp:param name="total" value="<%= total %>" />
</jsp:forward>
<%
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>
