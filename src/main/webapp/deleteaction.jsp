<%@page import ="java.sql.*" %>
<%@page import ="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Delete Action</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            width: 90%;
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
            padding: 20px;
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 30px;
        }
        
        .message-box {
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .success {
            background-color: #d5f5e3;
            border: 1px solid #2ecc71;
            color: #27ae60;
        }
        
        .error {
            background-color: #fadbd8;
            border: 1px solid #e74c3c;
            color: #c0392b;
        }
        
        .processing {
            background-color: #ebf5fb;
            border: 1px solid #3498db;
            color: #2980b9;
        }
        
        a {
            display: inline-block;
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
            transition: background-color 0.3s;
        }
        
        a:hover {
            background-color: #2980b9;
        }
        
        .details {
            background-color: white;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: left;
        }
        
        .details p {
            margin: 5px 0;
        }
        
        .details strong {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Delete Record</h1>
        
        <% 
        String id = request.getParameter("delid");
        String tablename = request.getParameter("tablist");
        
        // Validate input parameters
        if(id == null || id.isEmpty() || tablename == null || tablename.isEmpty()) {
        %>
            <div class="message-box error">
                <p>Error: Missing required parameters. Please provide both ID and table name.</p>
            </div>
            <a href="delete.jsp">Go Back</a>
        <%
        } else {
            try {
                // Display processing message
        %>
                <div class="message-box processing">
                    <p>Processing delete request...</p>
                </div>
                
                <div class="details">
                    <p><strong>Table:</strong> <%= tablename %></p>
                    <p><strong>Record ID:</strong> <%= id %></p>
                </div>
        <%
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection connect = DriverManager.getConnection
                ("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false","root","");
                
                // Use PreparedStatement with parameter binding for security
                String query = "DELETE FROM " + tablename + " WHERE id = ?";
                PreparedStatement psm = connect.prepareStatement(query);
                psm.setString(1, id);
                
                int rowsAffected = psm.executeUpdate();
                
                if(rowsAffected > 0) {
        %>
                    <div class="message-box success">
                        <p>Record successfully deleted!</p>
                        <p><%= rowsAffected %> row(s) affected</p>
                    </div>
        <%
                } else {
        %>
                    <div class="message-box error">
                        <p>No records found matching ID <%= id %> in table <%= tablename %>.</p>
                    </div>
        <%
                }
                
                // Close resources
                psm.close();
                connect.close();
                
                // Redirect after short delay
                response.setHeader("Refresh", "2;URL=delete.jsp");
            } catch(SQLException e) {
        %>
                <div class="message-box error">
                    <p>Database Error: <%= e.getMessage() %></p>
                </div>
        <%
            } catch(Exception e) {
        %>
                <div class="message-box error">
                    <p>Error: <%= e.getMessage() %></p>
                </div>
        <%
            }
        %>
            <a href="delete.jsp">Return to Delete Page</a>
        <% } %>
    </div>
</body>
</html>