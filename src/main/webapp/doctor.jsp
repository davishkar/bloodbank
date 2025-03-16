<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Doctor JSP</title>
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f0f4f8;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        /* Center container */
        center {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Page title */
        p {
            font-size: 28px;
            font-weight: bold;
            color: #e74c3c;
            margin: 20px 0;
            text-align: center;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border-radius: 8px;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        table td, table th {
            padding: 12px 15px;
            text-align: left;
            border: none;
        }

        table tr {
            border-bottom: 1px solid #ddd;
        }

        table tr:first-child {
            background-color: #e74c3c;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Back link */
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #2980b9;
        }

        /* Form styles (for doctor input form) */
        form {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        form input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        form input[type="submit"] {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        form input[type="submit"]:hover {
            background-color: #c0392b;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            form {
                padding: 15px;
            }
        }

        /* Success/error messages */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border-left: 5px solid #28a745;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border-left: 5px solid #dc3545;
        }

        /* Section title */
        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 30px;
        }

        .section-title:after {
            content: '';
            display: block;
            width: 50%;
            height: 3px;
            background-color: #e74c3c;
            margin: 10px auto 0;
        }
    </style>
</head>

<body>
    <center>
        <%
        //int docid=3000; 
        String docname = request.getParameter("doctorname"); 
        String docaddr = request.getParameter("doctoraddress"); 
        String doccontact = request.getParameter("doctorcontact"); 
        String docbg = request.getParameter("doctorbg");
        
        try { 
            Class.forName("com.mysql.jdbc.Driver").newInstance(); 
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", "root", "");
            //NOTE --> IN THE URL "bloodbank" IS THE NAME OF THE DATABASE. REPLACE THE WORD "bloodbank" WITH THE DATABASE NAME TO CONNECT TO YOUR DATABASE.
            
            String sql = "insert into doctor(id,doctorname,doctoraddress,doctorcontact,doctorbg) values(?,?,?,?,?)";
            PreparedStatement preparestatement = con.prepareStatement(sql);
            preparestatement.setString(1, null);
            preparestatement.setString(2, docname);
            preparestatement.setString(3, docaddr);
            preparestatement.setString(4, doccontact);
            preparestatement.setString(5, docbg);
            preparestatement.execute();
        } catch (SQLException e) {
            out.println("error in loading data");
            out.println(e);
        }
        %>
        <p>Doctor</p>
        <table border="1">
            <tr>
                <td>Doctor ID</td>
                <td>Doctor Name</td>
                <td>Doctor Address</td>
                <td>Doctor Contact</td>
                <td>Doctor Blood Group</td>
            </tr>
            <% 
            try { 
                Class.forName("com.mysql.jdbc.Driver").newInstance(); 
                java.sql.Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", "root", "");
                Statement fetchdata = connect.createStatement(); 
                String sqlquery = "select * from doctor";
                ResultSet displaydata = fetchdata.executeQuery(sqlquery); 
                
                while(displaydata.next()) {
            %>
                <tr>
                    <td><%=displaydata.getString("id") %></td>
                    <td><%=displaydata.getString("doctorname") %></td>
                    <td><%=displaydata.getString("doctoraddress") %></td>
                    <td><%=displaydata.getString("doctorcontact") %></td>
                    <td><%=displaydata.getString("doctorbg") %></td>
                </tr>
            <% 
                } 
            } catch(Exception e) { 
                System.out.println(e); 
            } 
            %>
        </table>
        <a href="menu.html">Go Back To Menu</a>
    </center>
</body>
</html>