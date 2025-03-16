# Blood Bank Management System

This project is a Blood Bank Management System designed for the administrator of the blood bank. It is built using JSP (Java Server Pages) and MySQL.

## Software Requirements
- **Eclipse IDE**: [Download Here](https://www.eclipse.org/downloads/)
- **XAMPP Server**: [Download Here](https://sourceforge.net/projects/xampp/)
- **MySQL Workbench (Optional)**: [Download Here](https://dev.mysql.com/downloads/workbench/)
- **Connector/J**: [Download Here](https://dev.mysql.com/downloads/connector/j/) *(Choose platform-independent if your OS is not listed)*

## Setting Up Eclipse IDE for JSP Development
To create a JSP project in Eclipse IDE, you need to enable the **Dynamic Web Project** feature. If this option is missing, follow these steps:

1. Open Eclipse IDE and navigate to **Help → Install New Software**.
2. In the "Work with" field, paste one of these links:
   - `http://download.eclipse.org/releases/mars`
   - If the above doesn't work, try `http://download.eclipse.org/releases/kepler`
   - Wait for the modules to load.
3. Navigate to **Web, XML, Java EE, and OSGi Enterprise Development** (at the bottom of the list).
4. Expand the module and select the following sub-modules:
   - Eclipse Java EE Developer Tools
   - Eclipse Java Web Developer Tools
   - Eclipse Web Developer Tools
   - JST Server Adapters Extensions *(available in the Mars link)*
   - JST Server Adapters *(available in the Mars link)*
5. Click **Next** and install them.
6. Restart Eclipse to apply the changes.

After restarting, you should see the **Dynamic Web Project** option under **File → New**.

## Configuring Tomcat Runtime in Eclipse

1. Create a new **Dynamic Web Project**.
2. In the pop-up window, set:
   - **Target Runtime**: Tomcat v7.0 (or latest version available)
   - **Dynamic Web Module Version**: 3.0
3. If Tomcat is not listed:
   - Click **New Runtime**.
   - Choose "Tomcat v7.0" (or the latest version available).
   - Check "Create new local server" and click **Next**.
   - Browse to your XAMPP installation directory and select the `tomcat` folder.
   - Click **Finish**.
4. Your project is now set up. Place all JSP files, images, and HTML files inside the `WebContent` folder.

## Adding MySQL Connector/J
1. Extract the downloaded **Connector/J** zip file.
2. Locate the JAR file inside the extracted folder.
3. Move this JAR file to the `lib` folder inside `WEB-INF`. *(Create `lib` if it does not exist.)*
4. Add the JAR file to your project:
   - Right-click the project → **Properties**.
   - Navigate to **Java Build Path** → **Libraries**.
   - Click **Add External JARs** and select the Connector/J JAR file.
   - Click **Apply and Close**.

## Database Setup
Before running the project, the database must be created or imported.

### Creating the Database
1. Open the **XAMPP Control Panel** and start **Apache**, **MySQL**, and **Tomcat**.
2. Open a browser and go to `http://localhost`.
3. Click **phpMyAdmin** (top right corner).
4. Create a new database manually or use **MySQL Workbench**.

### Importing an SQL File
1. In phpMyAdmin, go to **Databases**, enter a name, and click **Create**.
2. Select the database and navigate to the **Import** tab.
3. Click **Browse**, select the SQL file, and click **Go**.
4. If the import fails, adjust the character set and try again.

> **Note:** In the database connection URL, ensure the database name matches your created database. For example, if the database is named `bloodbank`, replace the word `bloodbank` in your connection URL accordingly.

## Running the Project
1. Open **XAMPP Control Panel** and start **Apache** and **MySQL** services.
2. Open a JSP file in Eclipse and click the **Run** button.
3. Choose the localhost runtime you created.
4. If everything is set up correctly, the application should launch in a new browser window.

## Stopping the Server
1. In Eclipse, go to the **Servers** tab (bottom of the screen).
2. Right-click the server and select **Stop**.
3. Stop **Apache** and **MySQL** services in the XAMPP Control Panel.

---
Your Blood Bank Management System is now ready to use!

