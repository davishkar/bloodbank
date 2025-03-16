<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donation Form</title>
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
            max-width: 800px;
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        input[type="text"],
        input[type="date"],
        input[type="tel"],
        select, 
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .radio-group {
            display: flex;
            gap: 15px;
            margin-top: 5px;
        }
        
        .radio-option {
            display: flex;
            align-items: center;
        }
        
        .radio-option input {
            margin-right: 5px;
        }
        
        .blood-group-options {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-top: 5px;
        }
        
        .blood-option {
            display: flex;
            align-items: center;
        }
        
        .blood-option input {
            margin-right: 5px;
        }
        
        .buttons {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #e60000;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #cc0000;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .error {
            color: #e60000;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Blood Donation Form</h1>
        
        <form action="receiveraction.jsp" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="receivername" required>
            </div>
            
            <div class="form-group">
                <label>Gender:</label>
                <div class="radio-group">
                    <div class="radio-option">
                        <input type="radio" id="male" name="receivergender" value="male" required>
                        <label for="male">Male</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="female" name="receivergender" value="female">
                        <label for="female">Female</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="other" name="receivergender" value="other">
                        <label for="other">Other</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="receiveraddress" rows="3" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="receiverdate" required>
            </div>
            
            <div class="form-group">
                <label for="contact">Contact:</label>
                <input type="tel" id="contact" name="receivercontact" required>
            </div>
            
            <div class="form-group">
                <label>Blood Group:</label>
                <div class="blood-group-options">
                    <div class="blood-option">
                        <input type="radio" id="apos" name="receiverbg" value="A+" required>
                        <label for="apos">A+</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="aneg" name="receiverbg" value="A-">
                        <label for="aneg">A-</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="bpos" name="receiverbg" value="B+">
                        <label for="bpos">B+</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="bneg" name="receiverbg" value="B-">
                        <label for="bneg">B-</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="abpos" name="receiverbg" value="AB+">
                        <label for="abpos">AB+</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="abneg" name="receiverbg" value="AB-">
                        <label for="abneg">AB-</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="opos" name="receiverbg" value="O+">
                        <label for="opos">O+</label>
                    </div>
                    <div class="blood-option">
                        <input type="radio" id="oneg" name="receiverbg" value="O-">
                        <label for="oneg">O-</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="doctor">Select Doctor:</label>
                <select id="doctor" name="doclist" required>
                    <option value="">-- Select Doctor --</option>
                    <% 
                    ResultSet doctornames = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        java.sql.Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                            "root", "");
                        Statement fetchdoctorname = con.createStatement();
                        doctornames = fetchdoctorname.executeQuery("select doctorname from doctor");
                        
                        while(doctornames.next()) {
                    %>
                    <option value="<%= doctornames.getString(1) %>"><%= doctornames.getString(1) %></option>
                    <% 
                        }
                    } catch(Exception e) {
                        out.println("<div class='error'>Error loading doctors: " + e.getMessage() + "</div>");
                    }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="donor">Select Donor ID:</label>
                <select id="donor" name="donlist" required>
                    <option value="">-- Select Donor ID --</option>
                    <% 
                    ResultSet donorids = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        java.sql.Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/bloodbank?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false",
                            "root", "");
                        Statement fetchdonorid = con.createStatement();
                        donorids = fetchdonorid.executeQuery("select id from donor");
                        
                        while(donorids.next()) {
                    %>
                    <option value="<%= donorids.getString(1) %>"><%= donorids.getString(1) %></option>
                    <% 
                        }
                    } catch(Exception e) {
                        out.println("<div class='error'>Error loading donor IDs: " + e.getMessage() + "</div>");
                    }
                    %>
                </select>
            </div>
            
            <div class="buttons">
                <a href="menu.html" class="btn btn-secondary">Go Back To Menu</a>
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>