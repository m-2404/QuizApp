<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="2;url=Welcome.jsp" />
    <title>Logging Out...</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #764ba2;
            color: #fff;
            text-align: center;
            padding-top: 100px;
        }
    </style>
</head>
<body>
    <%
        if (session != null) {
            session.invalidate();
        }
    %>
    <h1>You have been logged out</h1>
    <p>Redirecting to homepage...</p>
</body>
</html>
