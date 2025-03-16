<%@page import ="java.sql.*" %>
<%@page import ="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Inventory JSP</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        
        p {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin: 20px 0;
        }
        
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        
        table td, table th {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        table tr:hover {
            background-color: #e0e0e0;
        }
        
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        
        a:hover {
            background-color: #45a049;
        }
        
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
        // Only process form submission if parameters are present
        String bgname = request.getParameter("bgname");
        String bgquantityStr = request.getParameter("bgquantity");
        
        if (bgname != null && bgquantityStr != null && !bgname.isEmpty() && !bgquantityStr.isEmpty()) {
            try {
                float bgquantity = Float.parseFloat(bgquantityStr);
                
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection
                ("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false","root","");
                
                String sql="insert into inventory(id,bgname,quantity)values(?,?,?)";
                PreparedStatement preparestatement=con.prepareStatement(sql);
                preparestatement.setString(1,null);
                preparestatement.setString(2,bgname);
                preparestatement.setString(3,String.valueOf(bgquantity));
                preparestatement.execute();
                
                out.println("<div style='color:green;margin:15px;'>Record added successfully!</div>");
            } catch(SQLException e) {
                out.println("<div class='error'>Database error: " + e.getMessage() + "</div>");
            } catch(NumberFormatException e) {
                out.println("<div class='error'>Invalid quantity format. Please enter a valid number.</div>");
            } catch(Exception e) {
                out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
            }
        }
        %>
        
        <p>Inventory</p>
        <table>
            <tr>
                <td>Blood Group ID</td>
                <td>Blood Group</td>
                <td>Quantity</td>
            </tr>
            <% 
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection connect = DriverManager.getConnection
                ("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false","root","");
                Statement fetchdata = connect.createStatement();
                String sqlquery = "select * from inventory";
                ResultSet displaydata = fetchdata.executeQuery(sqlquery);
                
                while(displaydata.next()) {
            %>
                <tr>
                    <td><%=displaydata.getString("id") %></td>
                    <td><%=displaydata.getString("bgname") %></td>
                    <td><%=displaydata.getString("quantity") %></td>
                </tr>
            <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='3' class='error'>Error displaying inventory: " + e.getMessage() + "</td></tr>");
            }
            %>
        </table>
        <a href="menu.html">Go Back To Menu</a>
    </div>
</body>
</html>