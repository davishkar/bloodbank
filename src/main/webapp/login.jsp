<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login JSP</title>
    <style>
        /* Reset some basic elements */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Arial', sans-serif;
}

body {
  background-color: #f5f5f5;
  color: #333;
  line-height: 1.6;
  padding: 20px;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

/* Center content */
center {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 30px;
  width: 100%;
  max-width: 500px;
}

/* Headings */
h1, h2, h3 {
  color: #2c3e50;
  margin-bottom: 20px;
}

/* Links */
a {
  color: #3498db;
  text-decoration: none;
  transition: color 0.3s;
}

a:hover {
  color: #2980b9;
  text-decoration: underline;
}

/* Form styling */
form {
  margin: 20px 0;
}

input[type="text"], 
input[type="password"] {
  width: 100%;
  padding: 12px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 16px;
}

input[type="submit"] {
  background-color: #3498db;
  color: white;
  padding: 12px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

input[type="submit"]:hover {
  background-color: #2980b9;
}

/* Error messages */
.error {
  color: #e74c3c;
  margin: 10px 0;
  font-weight: bold;
}

/* Success messages */
.success {
  color: #2ecc71;
  margin: 10px 0;
  font-weight: bold;
}

/* Responsive adjustments */
@media (max-width: 600px) {
  center {
    padding: 20px;
  }
  
  input[type="text"], 
  input[type="password"],
  input[type="submit"] {
    padding: 10px;
  }
}

/* Blood bank specific theming */
.blood-red {
  color: #e74c3c;
}

.logo {
  max-width: 150px;
  margin-bottom: 20px;
}

/* Back button styling */
.back-button {
  display: inline-block;
  margin-top: 20px;
  padding: 10px 15px;
  background-color: #f1f1f1;
  border-radius: 4px;
  color: #555;
}

.back-button:hover {
  background-color: #e0e0e0;
  text-decoration: none;
}
    </style>
</head>
<body>
    <center>
        <%
            Connection conn = null;
            String uname = request.getParameter("username");
            String passwd = request.getParameter("password");
            
            try {
                String url = "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
                //NOTE --> IN THE URL "bloodbank" IS THE NAME OF THE DATABASE. REPLACE THE WORD "bloodbank" WITH THE DATABASE NAME TO CONNECT TO YOUR DATABASE.
                String username = "root";
                String password = "";
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                
                String Query = "select * from logindetails where username=? and passwd=?";
                PreparedStatement psm = conn.prepareStatement(Query);
                psm.setString(1, uname);
                psm.setString(2, passwd);
                
                ResultSet rs = psm.executeQuery();
                
                if (rs.next()) {
                    response.sendRedirect("menu.html");
                } else {
                    out.println("<div class='error'>Login Failed!<br>Please Try Again</div>");
                }
            } catch(Exception e) {
                out.print("<div class='error'>" + e + "</div>");
            }
        %>
        <br><br>
        <a href="index.html" class="back-button">Go Back To Login</a>
    </center>
</body>
</html>