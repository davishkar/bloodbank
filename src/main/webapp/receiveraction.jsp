<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receiver Records</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            text-align: center;
            color: #e60000;
            margin-bottom: 30px;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }
        
        th {
            background-color: #e60000;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 14px;
        }
        
        tr:nth-child(even) {
            background-color: #f8f8f8;
        }
        
        tr:hover {
            background-color: #f1f1f1;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            text-align: center;
        }
        
        .btn-primary {
            background-color: #e60000;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #cc0000;
        }
        
        .text-center {
            text-align: center;
        }
        
        .responsive-table {
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Blood Receiver Records</h1>
        
        <% 
        boolean insertSuccess = false;
        String errorMessage = "";
        
        //Process form submission
        if(request.getParameter("receivername") != null) {
            String rname = request.getParameter("receivername");
            String rgender = request.getParameter("receivergender");
            String raddress = request.getParameter("receiveraddress");
            String rdate = request.getParameter("receiverdate");
            String rcontact = request.getParameter("receivercontact");
            String rbg = request.getParameter("receiverbg");
            String docname = request.getParameter("doclist");
            String donid = request.getParameter("donlist");
            
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                    "root", "");
                
                String sql = "insert into receiver(id,receivername,gender,address,date,quantity,contact,bg,doctorname,donorid) values(?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement preparestatement = con.prepareStatement(sql);
                preparestatement.setString(1, null);
                preparestatement.setString(2, rname);
                preparestatement.setString(3, rgender);
                preparestatement.setString(4, raddress);
                preparestatement.setString(5, rdate);
                preparestatement.setString(6, String.valueOf(350));
                preparestatement.setString(7, rcontact);
                preparestatement.setString(8, rbg);
                preparestatement.setString(9, docname);
                preparestatement.setString(10, donid);
                preparestatement.execute();
                
                insertSuccess = true;
            } catch(SQLException e) {
                errorMessage = "Error in adding receiver record: " + e.getMessage();
            }
        }
        
        // Display success or error message
        if(insertSuccess) {
        %>
            <div class="success-message">
                Receiver record has been successfully added to the database.
            </div>
        <% } else if(!errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
        
        <div class="responsive-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Address</th>
                        <th>Date</th>
                        <th>Quantity (ml)</th>
                        <th>Contact</th>
                        <th>Blood Group</th>
                        <th>Doctor</th>
                        <th>Donor ID</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    try {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        java.sql.Connection connect = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                            "root", "");
                        
                        Statement fetchdata = connect.createStatement();
                        String sqlquery = "select * from receiver";
                        ResultSet displaydata = fetchdata.executeQuery(sqlquery);
                        
                        boolean hasRecords = false;
                        
                        while(displaydata.next()) {
                            hasRecords = true;
                    %>
                        <tr>
                            <td><%= displaydata.getString("id") %></td>
                            <td><%= displaydata.getString("receivername") %></td>
                            <td><%= displaydata.getString("gender") %></td>
                            <td><%= displaydata.getString("address") %></td>
                            <td><%= displaydata.getString("date") %></td>
                            <td><%= displaydata.getString("quantity") %></td>
                            <td><%= displaydata.getString("contact") %></td>
                            <td><%= displaydata.getString("bg") %></td>
                            <td><%= displaydata.getString("doctorname") %></td>
                            <td><%= displaydata.getString("donorid") %></td>
                        </tr>
                    <% 
                        }
                        
                        if(!hasRecords) {
                    %>
                        <tr>
                            <td colspan="10" class="text-center">No records found in the database.</td>
                        </tr>
                    <% 
                        }
                    } catch(Exception e) {
                    %>
                        <tr>
                            <td colspan="10" class="text-center">Error loading records: <%= e.getMessage() %></td>
                        </tr>
                    <% 
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="text-center">
            <a href="menu.html" class="btn btn-primary">Go Back To Menu</a>
        </div>
    </div>
</body>
</html>