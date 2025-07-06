<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" %>
<%
String category = request.getParameter("category");
String subcategory = request.getParameter("subcategory");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>QuizApp - Choose Test</title>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: #fff;
    text-align: center;
    margin: 0;
    padding: 30px;
  }

  h1 {
    margin-bottom: 20px;
    font-size: 2.8em;
    text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
  }

  h2 {
    margin-top: 30px;
    font-weight: normal;
    color: #f0e6ff;
  }

  .button {
    display: inline-block;
    padding: 14px 28px;
    margin: 10px;
    font-size: 1.1em;
    color: #5a2e91;
    background: #fff;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: 0.3s;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    text-decoration: none;
  }

  .button:hover {
    background: #dcd6f7;
    color: #3f1d6f;
    box-shadow: 0 6px 20px rgba(220,214,247,0.5);
  }

  .test-buttons {
    margin-top: 20px;
  }

  form {
    display: inline-block;
  }
</style>
</head>
<body>

<h1>QuizApp</h1>

<% if (category == null) { %>
  <h2>Select Category</h2>
  <form method="get">
    <button class="button" type="submit" name="category" value="Aptitude">Aptitude</button>
    <button class="button" type="submit" name="category" value="General Knowledge">General Knowledge</button>
    <button class="button" type="submit" name="category" value="JEE">JEE</button>
    <button class="button" type="submit" name="category" value="NEET">NEET</button>
  </form>

<% } else if ((category.equals("JEE") || category.equals("NEET")) && subcategory == null) { %>
  <h2>Select Subcategory for <%= category %></h2>
  <form method="get">
    <input type="hidden" name="category" value="<%= category %>"/>
    <% if (category.equals("JEE")) { %>
      <button class="button" type="submit" name="subcategory" value="Physics">Physics</button>
      <button class="button" type="submit" name="subcategory" value="Chemistry">Chemistry</button>
      <button class="button" type="submit" name="subcategory" value="Maths">Maths</button>
    <% } else { %>
      <button class="button" type="submit" name="subcategory" value="Physics">Physics</button>
      <button class="button" type="submit" name="subcategory" value="Chemistry">Chemistry</button>
      <button class="button" type="submit" name="subcategory" value="Biology">Biology</button>
    <% } %>
  </form>

<% } else { 
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_app", "root", "1234");
      
      String sql = "SELECT * FROM tests WHERE category = ?";
      if (subcategory != null) {
          sql += " AND subcategory = ?";
          ps = conn.prepareStatement(sql);
          ps.setString(1, category);
          ps.setString(2, subcategory);
      } else {
          ps = conn.prepareStatement(sql);
          ps.setString(1, category);
      }

      rs = ps.executeQuery();
      boolean hasTests = false;
%>
  <h2>Available Tests</h2>
  <div class="test-buttons">
<%
      while (rs.next()) {
          hasTests = true;
%>
    <form action="TestServlet" method="get">
      <input type="hidden" name="test_id" value="<%= rs.getInt("test_id") %>">
      <button class="button" type="submit">Attempt <%= rs.getString("test_name") %></button>
    </form>
<%
      }
      if (!hasTests) {
%>
    <p>No tests available for <%= category %> <% if (subcategory != null) { %> - <%= subcategory %><% } %>.</p>
<%
      }
%>
  </div>

  <form method="get">
    <button class="button" type="submit">Back to Categories</button>
  </form>

<%
  } catch(Exception e) {
      out.println("Error: " + e.getMessage());
  } finally {
      if (rs != null) rs.close();
      if (ps != null) ps.close();
      if (conn != null) conn.close();
  }
} %>

</body>
</html>
