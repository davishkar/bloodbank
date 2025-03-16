<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Records</title>
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
            max-width: 1100px;
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
        
        .responsive-table {
            overflow-x: auto;
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
            margin-top: 10px;
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
        
        .donor-stats {
            display: flex;
            justify-content: space-around;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .stat-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 200px;
            margin: 10px;
        }
        
        .stat-number {
            font-size: 28px;
            font-weight: bold;
            color: #e60000;
            margin: 10px 0;
        }
        
        .stat-label {
            color: #555;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Blood Donor Records</h1>
        
        <% 
        boolean insertSuccess = false;
        String errorMessage = "";
        
        // Process form submission if parameters exist
        if(request.getParameter("donorname") != null) {
            String dname = request.getParameter("donorname");
            String dgender = request.getParameter("gender");
            String address = request.getParameter("address");
            String date = request.getParameter("date");
            String contact = request.getParameter("contact");
            String bg = request.getParameter("bg");
            
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                    "root", "");
                
                String sql = "insert into donor(id,name,gender,address,date,quantity,contact,bg)values(?,?,?,?,?,?,?,?)";
                PreparedStatement preparestatement = con.prepareStatement(sql);
                preparestatement.setString(1, null);
                preparestatement.setString(2, dname);
                preparestatement.setString(3, dgender);
                preparestatement.setString(4, address);
                preparestatement.setString(5, date);
                preparestatement.setString(6, String.valueOf(350));
                preparestatement.setString(7, contact);
                preparestatement.setString(8, bg);
                preparestatement.execute();
                
                insertSuccess = true;
            } catch(SQLException e) {
                errorMessage = "Error in adding donor record: " + e.getMessage();
            }
        }
        
        // Display success or error message if needed
        if(insertSuccess) {
        %>
            <div class="success-message">
                Donor record has been successfully added to the database.
            </div>
        <% } else if(!errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
        
        <%
        // Statistics variables
        int totalDonors = 0;
        int totalDonations = 0;
        int maleCount = 0;
        int femaleCount = 0;
        
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection connect = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                "root", "");
            
            Statement statsStatement = connect.createStatement();
            ResultSet countResult = statsStatement.executeQuery("SELECT COUNT(*) as total, " +
                                                              "SUM(quantity) as totalQuantity, " +
                                                              "SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) as maleCount, " +
                                                              "SUM(CASE WHEN gender='Female' THEN 1 ELSE 0 END) as femaleCount " +
                                                              "FROM donor");
            
            if(countResult.next()) {
                totalDonors = countResult.getInt("total");
                totalDonations = countResult.getInt("totalQuantity");
                maleCount = countResult.getInt("maleCount");
                femaleCount = countResult.getInt("femaleCount");
            }
        %>
        
        <div class="donor-stats">
            <div class="stat-card">
                <div class="stat-number"><%= totalDonors %></div>
                <div class="stat-label">Total Donors</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= totalDonations %> ml</div>
                <div class="stat-label">Total Blood Donated</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= maleCount %></div>
                <div class="stat-label">Male Donors</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= femaleCount %></div>
                <div class="stat-label">Female Donors</div>
            </div>
        </div>
        
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
                    </tr>
                </thead>
                <tbody>
                    <% 
                    Statement fetchdata = connect.createStatement();
                    String sqlquery = "select * from donor";
                    ResultSet displaydata = fetchdata.executeQuery(sqlquery);
                    
                    boolean hasRecords = false;
                    
                    while(displaydata.next()) {
                        hasRecords = true;
                    %>
                    <tr>
                        <td><%= displaydata.getString("id") %></td>
                        <td><%= displaydata.getString("name") %></td>
                        <td><%= displaydata.getString("gender") %></td>
                        <td><%= displaydata.getString("address") %></td>
                        <td><%= displaydata.getString("date") %></td>
                        <td><%= displaydata.getString("quantity") %></td>
                        <td><%= displaydata.getString("contact") %></td>
                        <td><%= displaydata.getString("bg") %></td>
                    </tr>
                    <% 
                    }
                    
                    if(!hasRecords) {
                    %>
                    <tr>
                        <td colspan="8" class="text-center">No donor records found.</td>
                    </tr>
                    <% 
                    }
                    } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="8" class="text-center">Error loading records: <%= e.getMessage() %></td>
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