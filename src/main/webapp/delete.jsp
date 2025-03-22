<%@page import ="java.sql.*" %>
<%@page import ="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Page</title>
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
        max-width: 1200px;
        margin: 0 auto;
        text-align: center;
    }
    
    h1 {
        color: #2c3e50;
        margin-bottom: 30px;
    }
    
    .form-section {
        background-color: white;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .form-title {
        font-size: 20px;
        color: #2980b9;
        margin-bottom: 20px;
    }
    
    form {
        margin-bottom: 20px;
    }
    
    input[type="number"], 
    input[type="text"], 
    select {
        padding: 10px;
        margin: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: 250px;
        font-size: 16px;
    }
    
    input[type="submit"], 
    input[type="reset"],
    button {
        background-color: #3498db;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }
    
    input[type="submit"]:hover, 
    input[type="reset"]:hover,
    button:hover {
        background-color: #2980b9;
    }
    
    input[type="reset"] {
        background-color: #e74c3c;
    }
    
    input[type="reset"]:hover {
        background-color: #c0392b;
    }
    
    .print-button {
        background-color: #f39c12;
    }
    
    .print-button:hover {
        background-color: #d35400;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        background-color: white;
    }
    
    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }
    
    th {
        background-color: #3498db;
        color: white;
        text-transform: uppercase;
        font-size: 14px;
    }
    
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    
    tr:hover {
        background-color: #e0e0e0;
    }
    
    .table-container {
        overflow-x: auto;
        margin-bottom: 30px;
    }
    
    a {
        display: inline-block;
        background-color: #2ecc71;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 4px;
        margin-top: 20px;
        transition: background-color 0.3s;
    }
    
    a:hover {
        background-color: #27ae60;
    }
    
    .error {
        color: #e74c3c;
        background-color: #fadbd8;
        padding: 10px;
        border-radius: 4px;
        margin: 10px 0;
    }
    
    .success {
        color: #2ecc71;
        background-color: #d5f5e3;
        padding: 10px;
        border-radius: 4px;
        margin: 10px 0;
    }
    
    @media print {
        body * {
            visibility: hidden;
        }
        .table-container, .table-container * {
            visibility: visible;
        }
        .table-container {
            position: absolute;
            left: 0;
            top: 0;
        }
        .no-print {
            display: none;
        }
    }
</style>
<script>
    function printTable() {
        window.print();
    }
</script>
</head>
<body>
<div class="container">
    <h1>Database Management</h1>
    
    <div class="form-section">
        <div class="form-title">Delete Record</div>
        <form method="get" action="deleteaction.jsp">
            <div>
                <label for="delid">Enter the ID:</label>
                <input type="number" id="delid" name="delid" required />
            </div>
            <div>
                <%
                ResultSet tablenames=null;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    java.sql.Connection con = DriverManager.getConnection
                    ("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false","root","");
                    Statement fetchtablename=con.createStatement();
                    tablenames=fetchtablename.executeQuery("show tables");
                %>
                <label for="tablist">Select Table:</label>
                <select id="tablist" name="tablist">
                    <% while(tablenames.next()) { %>
                        <option value="<%= tablenames.getString(1)%>"><%= tablenames.getString(1)%></option>
                    <% } %>
                </select>
                <%
                } catch(Exception e) {
                    out.println("<div class='error'>Error retrieving tables: " + e.getMessage() + "</div>");
                }
                %>
            </div>
            <div>
                <input type="submit" value="Delete" />
                <input type="reset" value="Cancel" />
            </div>
        </form>
    </div>
    
    <div class="form-section">
        <div class="form-title">Display Table Data</div>
        <form method="get" action="delete.jsp">
            <div>
                <label for="tablelist">Display Table:</label>
                <select id="tablelist" name="tablelist">
                    <option value="Donor">Donor</option>
                    <option value="Receiver">Receiver</option>
                    <option value="Doctor">Doctor</option>
                    <option value="Inventory">Inventory</option>
                </select>
            </div>
            <div>
                <input type="submit" value="Display" />
                <input type="reset" value="Cancel" />
            </div>
        </form>
    </div>
    
    <% 
    String tablename = request.getParameter("tablelist");
    if(tablename != null && !tablename.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection connection = DriverManager.getConnection
            ("jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false","root","");
            
            // Get column names
            DatabaseMetaData meta = connection.getMetaData();
            ResultSet rsColumns = meta.getColumns(null, null, tablename, null);
            
            // Create a statement and execute query
            String sql = "select * from " + tablename;
            Statement loadtable = connection.createStatement();
            ResultSet displaytable = loadtable.executeQuery(sql);
            
            // Get column count
            ResultSetMetaData rsmd = displaytable.getMetaData();
            int columnCount = rsmd.getColumnCount();
    %>
    
    <div class="table-container">
        <div class="form-title">Table: <%= tablename %></div>
        <div class="no-print">
            <button type="button" class="print-button" onclick="printTable()">Print Table</button>
        </div>
        <table>
            <thead>
                <tr>
                    <% 
                    // Display column headers
                    for (int i = 1; i <= columnCount; i++) { 
                    %>
                        <th><%= rsmd.getColumnName(i) %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% 
                // Display table data
                while (displaytable.next()) { 
                %>
                    <tr>
                        <% 
                        for (int i = 1; i <= columnCount; i++) { 
                            String value = displaytable.getString(i);
                            value = (value == null) ? "" : value;
                        %>
                            <td><%= value %></td>
                        <% } %>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <%
        } catch(SQLException e) {
            out.println("<div class='error'>Error in loading data: " + e.getMessage() + "</div>");
        } catch(Exception e) {
            out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
        }
    }
    %>
    
    <div>
        <a href="menu.html">Go Back To Menu</a>
    </div>
</div>
</body>
</html>