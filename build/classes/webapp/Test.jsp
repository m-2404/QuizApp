<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> questions = (List<Map<String, Object>>) session.getAttribute("questions");
    Integer timeLimit = (Integer) session.getAttribute("time_limit");
    if (questions == null || timeLimit == null) {
        response.sendRedirect("Quiz.jsp?error=Session+expired+or+no+test+data");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Attempt</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .question {
            margin-bottom: 20px;
            padding: 15px;
            border-bottom: 1px solid #ccc;
        }
        .options label {
            display: block;
            margin: 5px 0;
        }
        #timer {
            text-align: right;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            background: #3498db;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background: #2980b9;
        }
    </style>
    <script>
        let timeLeft = <%= timeLimit %>; // in seconds

        function updateTimer() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;
            document.getElementById("timer").innerText = 
                "Time Left: " + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
            
            if (timeLeft <= 0) {
                document.getElementById("quizForm").submit();
            } else {
                timeLeft--;
                setTimeout(updateTimer, 1000);
            }
        }

        window.onload = updateTimer;
    </script>
</head>
<body>
    <div class="container">
        <h1>Quiz Attempt</h1>
        <div id="timer"></div>

        <form id="quizForm" action="SubmitQuizServlet" method="post">
            <% 
                int serialNumber = 1; 
                for (Map<String, Object> q : questions) { 
            %>
                <div class="question">
                    <p><strong>Q <%= serialNumber %>:</strong> <%= q.get("question_text") %></p>
                    <div class="options">
                        <label>
                            <input type="radio" name="q_<%= q.get("question_id") %>" value="1"> <%= q.get("option1") %>
                        </label>
                        <label>
                            <input type="radio" name="q_<%= q.get("question_id") %>" value="2"> <%= q.get("option2") %>
                        </label>
                        <label>
                            <input type="radio" name="q_<%= q.get("question_id") %>" value="3"> <%= q.get("option3") %>
                        </label>
                        <label>
                            <input type="radio" name="q_<%= q.get("question_id") %>" value="4"> <%= q.get("option4") %>
                        </label>
                    </div>
                </div>
            <% 
                serialNumber++;
                } 
            %>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit">Submit Quiz</button>
            </div>
        </form>
    </div>
</body>
</html>
