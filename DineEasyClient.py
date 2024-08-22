import pymysql
from getpass import getpass
from datetime import datetime

def get_database_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='Infinite@311',
        database='dine_easy'
    )

def validate_user(connection, user_type, username, password):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('ValidateUser', (user_type, username, password))
            result = cursor.fetchone()
            return result[0]
    except pymysql.Error as e:
        print(f"Error: {e}")
        return 'Error'

def update_password(connection, user_type, username, old_password, new_password):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('UpdatePassword', (user_type, username, old_password, new_password))
            result = cursor.fetchone()
            return result[0]
    except pymysql.Error as e:
        print(f"Error: {e}")
        return 'Error'

def delete_account(connection, username):
    try:
        with connection.cursor() as cursor:
            cursor.execute('DELETE FROM user_login WHERE user_name = %s', (username,))
            connection.commit()
            print("Account deleted successfully.\n")
    except pymysql.Error as e:
        print(f"Error: {e}")

def get_customer_id(connection,username):
    try:
        with connection.cursor() as cursor:
            query = f'SELECT customer_id FROM customer WHERE user_name = "{username}"'
            cursor.execute(query)
            result = cursor.fetchone()
            return result[0]
    except pymysql.Error as e:
        print(f"Error: {e}")

def get_staff_id(connection,username):
    try:
        with connection.cursor() as cursor:
            query = f'SELECT staff_id FROM staff_member WHERE user_name = "{username}"'
            cursor.execute(query)
            result = cursor.fetchone()
            return result[0]
    except pymysql.Error as e:
        print(f"Error: {e}")

def display_restaurants(connection):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('DisplayRestaurants')
            result = cursor.fetchall()
            valid_restaurant_id = []
            for row in result:
                restaurant_id = row[0]
                valid_restaurant_id.append(str(restaurant_id))
                restaurant_name = row[1]
                print(f"{restaurant_id}. {restaurant_name}")
        return valid_restaurant_id
    except pymysql.Error as e:
        print(f"Error: {e}")

def get_food_items(connection, restaurant_id):
    cursor = connection.cursor()
    try:
        query = f'SELECT fi.item_id, fi.item_name, fi.item_description, fi.cost_of_item, fir.quantity_of_food_item FROM food_items fi JOIN food_items_restaurant fir ON fi.item_id = fir.item_id WHERE fir.restaurant_id = {restaurant_id}'
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    finally:
        cursor.close()

def add_order_to_database(connection,totalAmount, customer_id,card_number, restaurant_id):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('AddOrder', (totalAmount,customer_id,card_number, restaurant_id))
            cursor.execute("SELECT LAST_INSERT_ID() AS order_id")
            result = cursor.fetchone()
            order_id = result[0]
            connection.commit()
            return order_id
    except pymysql.Error as e:
        print(f"Error: {e}")

def add_order_items_to_database(connection,selected_items, restaurant_id, order_id):
    try:
        with connection.cursor() as cursor:
            for item_id,quantity_ordered in selected_items:
                cursor.callproc('AddItem', (item_id, quantity_ordered, restaurant_id, order_id))
            connection.commit()
    except pymysql.Error as e:
        print(f"Error: {e}")        

def verify_payment(connection, customer_id, card_number, expiration_date):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('VerifyPayment', (customer_id, card_number, expiration_date))
            result = cursor.fetchone()
            return result[0]  
    except pymysql.Error as e:
        print(f"Error: {e}")

def view_previous_orders(connection, customer_id):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetCustomerOrders', (customer_id,))
            result = cursor.fetchall()

            if not result:
                print("\n❗❗❗ No previous orders found.")
            else:
                print("\n================ Previous Orders ================")
                print("")
                print(f"{'Order_Id':<10}{'Order_Date':<15}{'Total_Amount':<15}{'Restaurant_Name':<20}\n")

                for row in result:
                    order_id = row[0] if row[0] is not None else 'N/A'
                    order_date = row[1].strftime('%Y-%m-%d') if row[1] is not None else 'N/A'
                    total_amount = row[2] if row[2] is not None else 'N/A'
                    restaurant_name = row[3] if row[3] is not None else 'N/A'

                    print(f"{order_id:<10}{order_date:<15}{total_amount:<15}{restaurant_name:<20}")


                print("\n----------------------------------------------------------")

    except pymysql.Error as e:
        print(f"Error: {e}")   
             
def place_order_and_pay(connection, customer_id):
    try:
        while True:
            print("\n================  RESTAURANTS ================")
            print("")
            valid_restaurant_id = display_restaurants(connection)
            restaurant_id = input(" \n 🔅 -------- Enter the restaurant ID to place an order (0 to exit): ")
            if restaurant_id == '0':
                break
            print(valid_restaurant_id)
            if(restaurant_id not in valid_restaurant_id):
                print("\n❗❗❗ Invalid input. Please enter a valid restaurant ID.")
                continue

            # Display food items for the selected restaurant
            food_items = get_food_items(connection, restaurant_id)
            total_amount = 0
            selected_items = []

            while True:
                print("\n================================================ Available Food Items ================================================")
                print("")
                print(f"{'Item_ID':<10}{'Item_Name':<20}{'Item_Description':<60}{'Item_Price':<15}{'Available_Quantity':<20}\n")

                for item in food_items:
                    food_id = item[0]
                    item_name = item[1]
                    item_description = item[2]
                    item_price = item[3]
                    available_quantity = item[4]

                    print(
                        f"{food_id:<10}{item_name:<20}{item_description:<60}${item_price:<15}{available_quantity:<20}"
                    )

                print("\n--------------------------------------------------------------------------------------------------------------------------")    
                item_id = input(
                    "\n🔅 -------- Enter the item ID to add to your order (Enter 0 to Proceed to Payment): "
                )

                if item_id == '0':
                    break

                try:
                    item_id = int(item_id)
                except ValueError:
                    print("\n❗❗❗ Invalid input. Please enter a valid item ID.")
                    continue

                # Validate item ID
                if item_id not in [item[0] for item in food_items]:
                    print("\n❗❗❗ Invalid item ID. Please enter a valid item ID.")
                    continue

                quantity = input("\n🔅 -------- Enter the quantity for the selected item: ")

                try:
                    quantity = int(quantity)
                except ValueError:
                    print("\n❗❗❗ Invalid input. Please enter a valid quantity.")
                    continue

                # Validate quantity
                available_quantity = [
                    item[4] for item in food_items if item[0] == item_id
                ][0]
                if quantity > available_quantity:
                    print(
                        "\n❗❗❗ Invalid quantity. Please enter a quantity within the available quantity."
                    )
                    continue

                # Calculate the cost for the selected item and add to total_amount
                selected_item = next(
                    (item for item in food_items if item[0] == item_id), None
                )
                if selected_item:
                    total_amount += quantity * selected_item[3]
                    selected_items.append((item_id, quantity))
                    print(
                        "\nItem added to the order. Current total amount ====> ${:.2f}".format(
                            total_amount
                        )
                    )
                else:
                    print("\n❗❗❗ Error: Selected item not found.")

            # Payment
            card_number = input("\n🔅 -------- Enter your payment card number: ")
            expiration_date = input(
                "🔅 -------- Enter your card's expiration date (YYYY-MM-DD): "
            )
            payment_result = verify_payment(
                connection, customer_id, card_number, expiration_date
            )

            if payment_result == 'Success':
                print("Order placed successfully. Payment successful.\n")
                order_id = add_order_to_database(
                    connection,total_amount, customer_id, card_number, restaurant_id
                )
                add_order_items_to_database(
                    connection, selected_items, restaurant_id, order_id
                )
                connection.commit()
                break
            else:
                print("")
                print(f"❗❗❗ Payment failed. Reason: {payment_result}")

    except pymysql.Error as e:
        print(f"Error: {e}")

def format_timedelta(td):
    if td is not None:
        seconds = int(td.total_seconds())
        hours, remainder = divmod(seconds, 3600)
        minutes, seconds = divmod(remainder, 60)
        return f"{hours:02d}:{minutes:02d}:{seconds:02d}"
    else:
        return 'N/A'

def view_customer_reservations(connection, customer_id):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetCustomerReservations', (customer_id,))
            result = cursor.fetchall()

            if not result:
                print("❗❗❗ No reservations found.")
            else:
                print("\n==================================== Your Reservations ====================================")
                print("")
                print(f"{'Restaurant Name':<25}{'Date':<15}{'Seating_Capacity':<20}{'Start_Time':<15}{'End_Time':<15}\n")
                for row in result:
                    restaurant_name = row[0] if row[0] is not None else 'N/A'
                    reservation_date = row[1].strftime('%Y-%m-%d') if row[1] is not None else 'N/A'
                    seating_capacity = row[2] if row[2] is not None else 'N/A'
                    start_time = format_timedelta(row[3])
                    end_time = format_timedelta(row[4])

                    print(f"{restaurant_name:<25}{reservation_date:<15}{seating_capacity:<20}{start_time:<15}{end_time:<15}")
                print("\n-------------------------------------------------------------------------------------------\n")
    except pymysql.Error as e:
        print(f"Error: {e}")

def display_non_reserved_tables(connection, restaurant_id, reservation_date, customer_id):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetNonReservedTables', (restaurant_id, reservation_date))
            result = cursor.fetchall()
            validTableId = []
            validStartTimes = []
            if not result:
                print("❗❗❗ Sorry, No available tables for reservation.")
            else:
                print("\n================ Available Tables ================")
                print(f"{'Table_Id':<10}{'Seating_Capacity':<20}{'Start_Time':<20}\n")

                for row in result:
                    table_id = row[0]
                    seating_capacity = row[1]
                    start_time = format_timedelta(row[2])
                    validTableId.append(table_id)
                    validStartTimes.append(start_time)

                    print(f"{table_id:<10}{seating_capacity:<20}{start_time:<20}")

                print("\n---------------------------------------------------")
                while True : 
                    table_id = input("\n🔅 -------- Enter the Table ID you want to reserve: ")
                    start_time = input("🔅 -------- Enter the start time for the reservation (HH:MM:SS): ")
                    if(str(table_id) in map(str, validTableId)) and (start_time in validStartTimes):
                        print("")
                        confirmation = input(f"🔅 -------- Confirm reservation for Table {table_id} on {reservation_date} at {start_time}? (Y/N): ").lower()            
                        if confirmation == 'y':
                            make_reservation(connection, customer_id, table_id, reservation_date, start_time)
                            break
                        else:
                            print("\n❗❗❗ Reservation canceled.")
                            break
                    else : 
                        print('\n❗❗❗ Invalid table ID or Start Time')
                        continue
    except pymysql.Error as e:
        print(f"Error: {e}")    

def make_reservation(connection, customer_id, table_id, reservation_date, start_time):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('MakeReservation', (customer_id, table_id, reservation_date, start_time))
            connection.commit()
            print("Reservation successful!\n")
    except pymysql.Error as e:
        print(f"Error: {e}") 

def check_food_item_quantity(connection, staff_id, item_name):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('CheckFoodItemQuantity', (staff_id, item_name))
            result = cursor.fetchone()

            if result:
                quantity = result[0]
                print("")
                print(f"Available quantity of {item_name} : {quantity}")
            else:
                print("\n❗❗❗ Error: Food item or restaurant not found.")
    except pymysql.Error as e:
        print(f"Error: {e}")

def update_food_item_quantity(connection, staff_id, item_name, new_quantity):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('UpdateFoodItemQuantity', (staff_id, item_name, new_quantity))
            result = cursor.fetchone()

            if result and result[0] == 'Success':
                connection.commit()
                print("\n Food item quantity updated successfully.")
            else:
                print("\n❗❗❗ Error: Food item not found for the given restaurant.")
    except pymysql.Error as e:
        print(f"Error: {e}")

def get_restaurant_manager_information(connection, staff_id):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('GetRestaurantManagerInformation', (staff_id,))
            result = cursor.fetchone()

            if result:
                restaurant_name,open_time, close_time, street_number,street_name,state_abr, zip_code, manager_first_name, manager_last_name  = result
                print("\n====== Restaurant Information ======")
                print("")
                print(f"Restaurant Name : {restaurant_name}")
                print(f"Openning Time : {open_time}")
                print(f"Closing Time : {close_time}")
                print(f"Address : {street_number},{street_name},{state_abr} {zip_code}")
                print("\n====== Manager Information ======")
                print("")
                if (manager_last_name == None):
                    manager_last_name = ''
                print(f"Manager Name: {manager_first_name} {manager_last_name}")
            else:
                print("\n❗❗❗ Error: Restaurant or manager not found.")
    except pymysql.Error as e:
        print(f"Error: {e}")  

def is_valid_manager(connection, manager_id):
    try:
        with connection.cursor() as cursor:
            query = f"SELECT COUNT(*) FROM staff_manager WHERE manager_id = {manager_id}"
            cursor.execute(query)
            result = cursor.fetchone()

            if result and result[0] > 0:
                return 'Success'
            else:
                print("\n❗❗❗ Error: Invalid Manager ID.")
                return ''
    except pymysql.Error as e:
        print(f"Error: {e}")
        return False      

def add_new_food_item(connection, staff_id, item_name, item_description, cost_of_item, initial_available_quantity):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('AddNewFoodItem', (staff_id, item_name, item_description, cost_of_item, initial_available_quantity))
            result = cursor.fetchone()

            if result:
                new_food_item_id = result[0]
                connection.commit()
                print("")
                print(f"New food item added successfully. Item ID: {new_food_item_id}")
            else:
                print("\n❗❗❗ An error occurred while adding the new food item.")

    except pymysql.Error as e:
        print(f"Error: {e}")      

def delete_food_item_by_name(connection, item_name):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('DeleteFoodItemByName', (item_name,))
            result = cursor.fetchone()

            if result:
                message = result[0]
                print('\n' + message)
            else:
                print("")
                print(f"❗❗❗ An error occurred while deleting the food item with name '{item_name}'.")

        connection.commit()

    except pymysql.Error as e:
        print(f"Error: {e}")    

def update_client_password(connection, user_choice, username):
    old_password = getpass("\n🔅 -------- Enter your old password: ")
    new_password = getpass("🔅 -------- Enter your new password: ")

    update_result = update_password(connection, user_choice, username, old_password, new_password)

    if update_result == 'Success':  
        print("\n Password updated successfully.")
    elif update_result == 'InvalidCredentials':
        print("\n❗❗❗ Invalid old password. Password update failed.")
    else:
        print("\n❗❗❗ An error occurred. Password update failed.")

    connection.commit()    
    

def handle_update_quantity(connection, staff_id):
    item_name = input("🔅 -------- Enter the name of the food item to update the quantity: ")
    check_food_item_quantity(connection, staff_id, item_name)
    newQuantity = input("🔅 -------- Enter the new quantity: ")
    update_food_item_quantity(connection, staff_id, item_name, newQuantity)


def handle_new_food_item(connection,staff_id):
    item_name = input("\n🔅 -------- Enter the name of the new food item: ")
    item_description = input("🔅 -------- Enter the description of the new food item: ")
    cost_of_item = float(input("🔅 -------- Enter the cost of the new food item: "))
    initial_available_quantity = int(input("🔅 -------- Enter initial available quantity: "))
    add_new_food_item(connection, staff_id, item_name,item_description,cost_of_item,initial_available_quantity)

def display_customer_menu():
    print("\n ----- Customer Menu -----\n")
    print("🔹 1. Update Password")
    print("🔹 2. Delete Account")
    print("🔹 3. Place order and pay")
    print("🔹 4. View Previous Orders")
    print("🔹 5. View your reservations")
    print("🔹 6. Make a reservation")

def display_staff_menu():
    print("\n ----- Staff Menu ----- ")
    print("🔹 1. Update Password")
    print("🔹 2. Delete Account")
    print("🔹 3. Check Food Item Quantity")
    print("🔹 4. Get Restaurant and Manager Information")

def display_manager_menu():
    print("\n ----- Manager Menu  ----- ")
    print("🔹 1. Update Password")
    print("🔹 2. Delete Account")
    print("🔹 3. Check Food Item Quantity")
    print("🔹 4. Update Available Food Item Quantity")
    print("🔹 5. Add new Food Item to the menu")
    print("🔹 6. Delete a food item")
    print("🔹 7. Get Restaurant and Manager Information")

def main():
    try:
        print("🔃 Attempting to establish a connection 🔃")
        with get_database_connection() as connection:
            print("🟢 Connection Established Successfully.🟢")
            
            while True:
                user_choice = input("\n🔅 -------- Are you a CUSTOMER, STAFF or MANAGER ? Enter 'customer', 'staff','manager' or 'exit': ").lower()

                if user_choice == 'exit':
                    print("\nExiting the program.")
                    print("")
                    break
                elif user_choice not in ['customer', 'staff', 'manager']:
                    print("❗❗❗ Invalid choice. Please enter 'customer', 'staff','manager' or 'exit'. \n")
                    continue
 
                if user_choice == 'customer' or user_choice == 'staff' or user_choice == 'manager':
                    print("\n -------------------------------- 💠 WELCOME 💠 -------------------------------- ")
                    username = input("\n🔅 -------- Enter your username: ")
                    password = getpass("🔅 -------- Enter your password: ")
                    if(user_choice=="manager"):
                        manager_id = input("🔅 -------- Enter you Manager Id to continue - ")
                        valid_manager = is_valid_manager(connection,manager_id)

                    validation_result = validate_user(connection, user_choice, username, password)

                    if validation_result == 'Success':
                        if(user_choice == 'manager'):
                            if(valid_manager == 'Success'):
                                print("")
                                print(f"Login successful as {user_choice}.")
                            else:
                                continue
                        else:       
                            print("")     
                            print(f"Login successful as {user_choice}.")

                        while True:
                            if user_choice == 'customer':
                                customer_id = get_customer_id(connection, username)
                                display_customer_menu()
                                option = input("\n 🔅 -------- Enter the option number or 'exit' to log out: ")

                                if option == 'exit':
                                    print("\nLogging out.")
                                    break
                                elif option == '1':
                                    update_client_password(connection, user_choice, username)
                                elif option == '2':
                                    confirmation = input("\n🔅 -------- Are you sure you want to delete your account? (Y/N): ").lower()
                                    if confirmation == 'y':
                                        delete_account(connection, username)
                                        break  
                                    else:
                                        print("\n❗❗❗ Account deletion canceled.")
                                elif option == '3':
                                    place_order_and_pay(connection, customer_id)
                                elif option == '4':
                                    view_previous_orders(connection, customer_id)  
                                elif option == '5':
                                    view_customer_reservations(connection, customer_id)
                                elif option == '6':
                                    display_restaurants(connection)
                                    restaurant_id = input("\n🔅 -------- Enter the restaurant ID where you want to make a reservation: ")
                                    reservation_date = input("🔅 -------- Enter the reservation date (YYYY-MM-DD): ")
                                    display_non_reserved_tables(connection, restaurant_id, reservation_date, customer_id)          
                                else:
                                    print("\n❗❗❗ Invalid option. Please enter a valid option.")


                            elif user_choice == 'staff':
                                staff_id = get_staff_id(connection,username)
                                display_staff_menu()
                                option = input("\n🔅 -------- Enter the option number or 'exit' to log out: ")

                                if option == 'exit':
                                    print("Logging out.")
                                    break
                                elif option == '1':
                                    update_client_password(connection, user_choice, username)
                                elif option == '2':
                                    confirmation = input("\n🔅 -------- Are you sure you want to delete your account? (Y/N): ").lower()
                                    if confirmation == 'y':
                                        delete_account(connection, username)
                                        break  
                                    else:
                                        print("\n❗❗❗ Account deletion canceled.")
                                elif option == '3':
                                    item_name = input("\n🔅 -------- Enter the name of the food item: ")
                                    check_food_item_quantity(connection, staff_id, item_name)
                                elif option == '4':
                                    get_restaurant_manager_information(connection, staff_id)                    
                                else:
                                    print("\n❗❗❗ Invalid option. Please enter a valid option.")

                            elif user_choice == 'manager':
                                    print("\n -------------- Welcome Manager -----------------")
                                    staff_id = get_staff_id(connection,username)
                                    display_manager_menu()
                                    option = input("\n🔅 -------- Enter the option number or 'exit' to log out: ")

                                    if option == 'exit':
                                        print("Logging out.")
                                        break
                                    elif option == '1':
                                        update_client_password(connection, user_choice, username)
                                    elif option == '2':
                                        confirmation = input("\n🔅 -------- Are you sure you want to delete your account? (Y/N): ").lower()
                                        if confirmation == 'y':
                                            delete_account(connection, username)
                                            break  
                                        else:
                                            print("\n❗❗❗ Account deletion canceled.")
                                    elif option == '3':
                                        item_name = input("\n🔅 -------- Enter the name of the food item: ")
                                        check_food_item_quantity(connection, staff_id, item_name)
                                    elif option == '4':
                                        handle_update_quantity(connection, staff_id)
                                    elif option == '5':
                                        handle_new_food_item(connection,staff_id)                    
                                    elif option == '6':
                                        item_name_to_delete = input("\n🔅 -------- Enter the name of the food item to delete: ")
                                        delete_food_item_by_name(connection, item_name_to_delete)
                                    elif option == '7':
                                        get_restaurant_manager_information(connection, staff_id)
                                    else:
                                        print("\n❗❗❗ Invalid option. Please enter a valid option.")


                    elif validation_result == 'InvalidUserType':
                        print("\n❗❗❗ Invalid user type. Please enter the correct user type.")
                    elif validation_result == 'InvalidCredentials':
                        print("\n❗❗❗ Invalid username or password. Login failed.")
                    else:
                        print("\n❗❗❗ An error occurred. Login failed.\n")

    except pymysql.err.OperationalError as e:
        if e.args[0] == 1045:
            print("\n❗❗❗ Error ----> Access denied. Please check your username and password !!")
        else:
            print(f"Error: {e}")

if __name__ == "__main__":
    main()
