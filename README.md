# QuizApp

A simple and interactive **Online Quiz Application** built using **Java (Servlets + JSP)** and **MySQL**, with a clean frontend using basic **HTML/CSS**.  

## 🚀 Features
- User Registration and Login  
- Test selection based on **Category** and **Subcategory**  
- Timed quiz attempt (auto-submit on timeout)  
- Scoring with correct/wrong answer feedback  
- Profile view  
- Logout functionality  

## 🛠 Technologies Used
- Java Servlets + JSP  
- Apache Tomcat  
- MySQL  
- JDBC  
- HTML + CSS  
- Git  

## 💻 Project Structure
QuizApp1/
├── src/main/java/ # Java servlets
├── src/main/webapp/ # JSP files, web resources
├── build/ # Compiled classes (can be ignored in version control)
├── .settings/, .classpath # Eclipse config files
└── WEB-INF/ # Web app config (web.xml, lib)



## ⚙️ Setup Instructions
1. **Clone the repository**
   ```bash
   git clone https://github.com/m-2404/QuizApp.git
Import into Eclipse
File → Import → Existing Projects into Workspace → Select your project folder.

Setup MySQL database

Create database quiz_app

Import tables (users, tests, questions, etc.)
(SQL scripts can be added or generated as needed)

Update DB credentials in your code


DB_URL = jdbc:mysql://localhost:xxxx/quiz_app
DB_USER = *your_user*
DB_PASS = *password*
Run on Tomcat Server

Add project to server

Start the server

Access at: http://localhost:XXXX/QuizApp1

📌 Notes
Make sure the MySQL server is running.

A .gitignore file is recommended to avoid committing build and IDE files.

🤝 Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

📜 License
This project is for educational purposes.

