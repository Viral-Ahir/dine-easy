# DineEasy - A Restaurant Management System

DineEasy is a **Restaurant Database Management System (RDMS)** designed to manage and streamline the day-to-day operations of a restaurant efficiently. It is a multi-user application that supports three user roles: `Customer`, `Staff`, and `Manager`.

---

## 🛠️ Installation

### 1. **Download the Files:**

- Download the zip file to access all the files.
- Extract the downloaded ZIP file to your desired location.
- Open the script in any IDE.

### 2. **Install Required Packages:**

- Open a command prompt, terminal, or IDE.
- Navigate to the extracted folder.
- Ensure Python is installed on your system.
- Install the required libraries using the following commands:
  ```bash
  pip install pymysql
  pip install getpass
  pip install datetime
  ```

### 3. **Import the Database:**

- Use the provided SQL dump file (`DineEasyDump.sql`) to import the database into your MySQL server.
- In MySQL Workbench, navigate to `Server → Data Import` to import the dump file.

---

## 🚀 Usage

### 1. **PreRequisite**

- Before running the application, enter the SQL username and password for your local instance in the `get_database_connection()` function in the `DineEasyClient.py` file.

### 2. **Run the Application:**

- In the command prompt or terminal, navigate to the application folder.
- Run the application using:
  ```bash
  python DineEasyClient.py
  ```

### 3. **Explore the Functionality:**

- The application allows you to log in as `Customer`, `Staff`, or `Manager`.
- After selecting a role, the user will be prompted to enter a valid username and password.
- You can find valid usernames and passwords in the `user_login` table in the database. The `is_staff` flag indicates whether the user is a staff member.
- For the manager (a staff member), an additional piece of information (Manager ID) will be required, which is available in the `staff_manager` table.

**Demo Login Credentials:**

- **Customer:**
  - Username: `Ross`
  - Password: `ross12`
- **Staff:**
  - Username: `Rachael`
  - Password: `rachael123`
- **Manager:**
  - Username: `Viral Ahir`
  - Password: `viral123`

**Functionality:**

- **A. CUSTOMER:**

  1.  Update user password
  2.  Delete Account
  3.  Place Order and Pay
  4.  View Previous Orders
  5.  View Reservations
  6.  Make a Reservation

- **B. STAFF:**

  1.  Update Staff Account Password
  2.  Delete Staff Account
  3.  Check Food Items Quantity
  4.  Get Restaurant and Manager Information

- **C. MANAGER:**
  1.  Update Manager Account Password
  2.  Delete Account
  3.  Check Food Items Quantity
  4.  Update Available Food Item Quantity
  5.  Add a New Food Item to the Menu
  6.  Delete a Food Item
  7.  Get Restaurant and Manager Information

### 4. **View Results:**

- Results will be displayed in the command line interface (CLI). Success or error messages will be shown, and you can verify results in the appropriate tables in MySQL Workbench.

### 5. **Error Handling:**

- The application handles various errors and displays appropriate messages to the user.

---
