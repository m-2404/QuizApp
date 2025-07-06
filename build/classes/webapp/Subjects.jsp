<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>QuizApp - Subjects</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: #fff;
    margin: 0;
    padding: 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  h1 {
    font-size: 3rem;
    margin-bottom: 30px;
    text-shadow: 0 2px 5px rgba(0,0,0,0.3);
  }
  form {
    margin: 10px;
  }
  button {
    padding: 12px 30px;
    font-size: 1.1rem;
    border: none;
    border-radius: 25px;
    background: #fff;
    color: #5a2e91;
    font-weight: bold;
    cursor: pointer;
    margin: 10px;
    transition: 0.3s;
  }
  button:hover {
    background: #dcd6f7;
    color: #3f1d6f;
  }
</style>
</head>
<body>

<h1>Select Subject</h1>

<form action="Quiz.jsp" method="get">
  <button type="submit" name="category" value="Aptitude">Aptitude</button>
  <button type="submit" name="category" value="General Knowledge">General Knowledge</button>
</form>

<h2>JEE</h2>
<form action="Quiz.jsp" method="get">
  <input type="hidden" name="category" value="JEE">
  <button type="submit" name="subcategory" value="Physics">Physics</button>
  <button type="submit" name="subcategory" value="Chemistry">Chemistry</button>
  <button type="submit" name="subcategory" value="Maths">Maths</button>
</form>

<h2>NEET</h2>
<form action="Quiz.jsp" method="get">
  <input type="hidden" name="category" value="NEET">
  <button type="submit" name="subcategory" value="Physics">Physics</button>
  <button type="submit" name="subcategory" value="Chemistry">Chemistry</button>
  <button type="submit" name="subcategory" value="Biology">Biology</button>
</form>

<a href="Welcome.jsp" style="margin-top: 30px; color: #fff; text-decoration: underline;">Back to Homepage</a>

</body>
</html>
