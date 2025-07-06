<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%
    int score = (int) request.getAttribute("score");
    int total = (int) request.getAttribute("total");
    List<Map<String, Object>> wrongQuestions = (List<Map<String, Object>>) request.getAttribute("wrongQuestions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>QuizApp - Result</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: #fff;
            margin: 0;
            padding: 40px 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        h1 {
            text-align: center;
            font-size: 2.5rem;
        }
        .summary {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.2);
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.3);
        }
        th {
            background: rgba(0,0,0,0.2);
        }
        tr:nth-child(even) {
            background: rgba(255,255,255,0.1);
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #fff;
            color: #2575fc;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            margin-top: 20px;
            transition: 0.3s ease;
        }
        .btn:hover {
            background: #dcd6f7;
            color: #3f1d6f;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Quiz Results</h1>
    <div class="summary">
        You scored <strong><%= score %></strong> out of <strong><%= total %></strong>
    </div>

    <% if (!wrongQuestions.isEmpty()) { %>
        <h2>Questions You Got Wrong</h2>
        <table>
            <tr>
                <th>Question</th>
                <th>Your Answer</th>
                <th>Correct Answer</th>
            </tr>
            <% for (Map<String, Object> wq : wrongQuestions) { %>
            <tr>
                <td><%= wq.get("question_text") %></td>
                <td><%= wq.get("selected_option") %></td>
                <td><%= wq.get("correct_option") %></td>
            </tr>
            <% } %>
        </table>
    <% } else { %>
        <p style="text-align:center; font-size:1.2rem; color:#0f0;">🎉 Perfect Score! Well done!</p>
    <% } %>

    <div style="text-align:center;">
        <a href="Subjects.jsp" class="btn">Back to Subjects</a>
    </div>
</div>
</body>
</html>
