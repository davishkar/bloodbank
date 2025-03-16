<%@ page import="java.sql.*" %>    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check Connection Page</title>
</head>
<body>
<%
Connection conn = null;
try {
    String url = "jdbc:mysql://localhost:3306/bloodbank?useSSL=false&serverTimezone=UTC";
    String username = "root"; // Your MySQL username
    String password = "";     // Your MySQL password

    // Load MySQL Driver (New version)
    Class.forName("com.mysql.cj.jdbc.Driver");


    // Establish the Connection
    conn = DriverManager.getConnection(url, username, password);

    if (conn != null) {
        out.print("Connected to Database");
    }
} catch (Exception e) {
    out.print("Not connected: " + e.getMessage());
} finally {
    if (conn != null) {
        try {
            conn.close();
            out.print("<br>Connection Closed Successfully");
        } catch (SQLException se) {
            out.print("<br>Error Closing Connection: " + se.getMessage());
        }
    }
}
%>
</body>
</html>
