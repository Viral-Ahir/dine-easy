# DineEasy - A Restaurant Management System

DineEasy is a Restaurant Database Management System (RDMS) designed to manage and streamline the day-to-day operations of a restaurant efficiently.

It is a multi user application that supports 3 user roles - `Customer`, `Staff`, and `Manager`.

## Installation

1. **Download the Files:**

   - Download the zip file to access all the files.
   - Extract the downloaded ZIP file to your desired location.
   - Open the script in any of the IDE.

2. **Install Required Packages:**

   - Open a command prompt or terminal or IDE.
   - Navigate to the extracted folder.
   - Make sure that python is installed in the system.
   - Install the required library (if it does not exist) using the following commands: pip install pymysql, pip install getpass, pip install datetime.

3. **Import the Database:**
   - Use the provided SQL dump file (`DineEasyDump.sql`) to import the database into your MySQL server.
   - To import a dump file in the MySQL Workbench navigate to (‘Server→ Data Import’) from the menu bar.

## Usage

1. **PreRequisite** - To run this application, please enter the SQL username and SQL password field of the local instance in the `get_database_connection()` function in the `DineEasyClient.py` file.

2. **Run the Application:**

   - In the command prompt or terminal, navigate to the application folder.
   - Run the following command: python DineEasyClient.py , to run the application code file (`DineEasyClient.py`).

3. **Explore the Functionality provide by our application:**

   - The application give you options to log in as `Customer`,`Staff` and `Manager`.

   After you select the option, the client will be asked to enter the valid username and password. You can look into the user_login table in the database to see the valid set of usernames and passwords currently supported by our application. The is_staff flag in the table represents if the user is staff or not.

   For manager(one of the staff member) a additional pience of information will be needed (i.e The manager id), which you can look out into the `staff_manager` table in the database.

   For demo purposes, I am providing you with one set of valid passwords and username.

   Customer -> Username - Ross , Password - ross12

   Staff -> Username - Rachael Password - rachael123

   Manager -> Username - Viral Ahir Password - viral123

   - The functionality that our program has to offer is listed below.

   **A. CUSTOMER:**

   1. Update user password – to update the login password for the current user.
   2. Delete the Account – to delete the account from the database.
   3. Place Order and Pay – Choose the restaurant, look into its menu, decide the food item to order, place order and make the payment by entering the card details.
   4. View Previous Orders – after logging in, the current user can see his/her previous orders placed
   5. View Reservations – view the current reservations for the current user.
   6. Make a reservation – make a reservation in the available restaurants for next date by choosing the time slot and table number.

   **B. STAFF:**

   1. Update Staff Account Password – Update the Password for the Staff
   2. Delete Staff Account – Delete the Staff account
   3. Check Food Items Quantity – check the quantity of food available to serve the customers.
   4. Get Restaurant and Manager Information – This will give the information of the restaurant where the staff is working, along with the Manager of the restaurant.

   **C. MANAGER:**

   1. Update Manager Account Password – Update the Password for the Manager
   2. Delete Account – Delete the Staff account
   3. Check Food Items Quantity – check the quantity of food available to serve the customers.
   4. Update Available Food item quantity – Update the available food quantity according to the restaurant requirements.
   5. Add a New Food Item to the Menu – Can add a new food item to the Restaurant Menu.
   6. Delete a Food Item – Can delete the food item from the restaurant.
   7. Get Restaurant and Manager Information – This will give the information of the restaurant where the staff is working, along with the Manager of the restaurant.

4. **View Results:**

   - Some of the results will be shown in the CLI itself. The appropriate message (Success or Error message) will be displayed in the CLI. To verify the results the client can look into the appropriate tables in MySql workbench.

5. **Errors and Invalid Inputs:**
   - The application handles all types of errors properly and displays appropriate message to the user.
