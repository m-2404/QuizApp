<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>QuizApp - Welcome</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');

  * {
    box-sizing: border-box;
  }

  body {
    font-family: 'Montserrat', sans-serif;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: #fff;
    margin: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 40px 20px;
  }

  header {
    text-align: center;
    margin-bottom: 50px;
  }

  h1 {
    font-size: 3.5rem;
    letter-spacing: 4px;
    margin: 0;
    text-shadow: 0 2px 5px rgba(0,0,0,0.3);
  }

  h2 {
    font-weight: 400;
    font-size: 1.4rem;
    margin-top: 8px;
    font-style: italic;
    color: #dcd6f7;
  }

  section.description {
    background: rgba(255,255,255,0.15);
    border-radius: 12px;
    padding: 25px 30px;
    max-width: 600px;
    line-height: 1.6;
    box-shadow: 0 8px 15px rgba(0,0,0,0.2);
    margin-bottom: 50px;
  }

  section.description ul {
    margin-top: 15px;
    padding-left: 20px;
  }

  button, a.button-link {
    background: #fff;
    color: #5a2e91;
    font-weight: 600;
    font-size: 1.1rem;
    padding: 14px 28px;
    margin: 8px;
    border: none;
    border-radius: 40px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255,255,255,0.4);
    text-decoration: none;
    display: inline-block;
    min-width: 140px;
    text-align: center;
  }

  button:hover, a.button-link:hover {
    background: #dcd6f7;
    color: #3f1d6f;
    box-shadow: 0 6px 20px rgba(220,214,247,0.6);
    transform: translateY(-3px);
  }

  #subject-section {
    margin-top: 30px;
    max-width: 600px;
    width: 100%;
    text-align: center;
  }

  @media (max-width: 600px) {
    h1 {
      font-size: 2.8rem;
    }

    section.description {
      padding: 20px;
    }

    button, a.button-link {
      width: 100%;
      margin: 10px 0;
      min-width: unset;
    }
  }
</style>
<script>
  function loadSubjects() {
    alert("Load subjects here via backend call.");
    // You can connect this to backend later
  }
</script>
</head>
<body>

<header>
  <h1>QuizApp</h1>
  <h2>“For All There is One”</h2>
</header>

<section class="description">
  <p>Welcome to <strong>QuizApp</strong> — your easy-to-use quiz platform. No registration required to start quizzes instantly!</p>
  <p><strong>Registering lets you:</strong></p>
  <ul>
    <li>Track your scores and progress</li>
    <li>See your strong and improvement areas</li>
    <li>Save quiz history</li>
    <li>Get personalized quiz recommendations</li>
  </ul>
</section>

<section>
  <form action="Subjects.jsp" method="get" style="display: inline;">
    <button type="submit">Subjects</button>
  </form>
</section>

<section>
  <% if (username == null) { %>
    <a href="Registration.jsp" class="button-link">Register</a>
    <a href="Login.jsp" class="button-link">Login</a>
  <% } else { %>
    <a href="Profile.jsp" class="button-link">Profile</a>
    <a href="Logout.jsp" class="button-link">Logout</a>
  <% } %>
</section>

<div id="subject-section"></div>

</body>
</html>
