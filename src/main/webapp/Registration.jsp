<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Register - QuizApp</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background: #667eea;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }
  .register-box {
    background: white;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    width: 350px;
  }
  h2 {
    margin-bottom: 25px;
    color: #333;
    text-align: center;
  }
  label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
    color: #555;
  }
  input[type=text], input[type=email], input[type=password] {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 6px;
    border: 1px solid #ccc;
    box-sizing: border-box;
  }
  button {
    margin-top: 25px;
    width: 100%;
    background-color: #5a2e91;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 40px;
    font-size: 1.1rem;
    cursor: pointer;
  }
  button:hover {
    background-color: #432069;
  }
  .message {
    margin-top: 15px;
    text-align: center;
  }
  .error {
    color: #d9534f;
  }
  .success {
    color: #4cae4c;
  }
  a {
    display: block;
    margin-top: 18px;
    text-align: center;
    color: #5a2e91;
    text-decoration: none;
  }
  a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>
  <div class="register-box">
    <h2>Register to QuizApp</h2>
    <form action="RegistrationServlet" method="post">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" required />

      <label for="email">Email</label>
      <input type="email" id="email" name="email" required />

      <label for="password">Password</label>
      <input type="password" id="password" name="password" required />

      <button type="submit">Register</button>
    </form>
    <a href="Login.jsp">Already have an account? Login here</a>
  </div>
</body>
</html>
