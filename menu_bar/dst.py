import mysql.connector
from mysql.connector import Error

def create_database(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            password=user_password
        )
        if connection.is_connected():
            print("Connected to MySQL server")

        cursor = connection.cursor()
        cursor.execute(f"CREATE DATABASE {db_name}")
        print(f"Database {db_name} created successfully")

    except Error as e:
        print(f"Error: '{e}'")

    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection closed")

# Configuration
host_name = "localhost"
user_name = "root"
user_password = ""
db_name = "my_first_database"

# Create Database
create_database(host_name, user_name, user_password, db_name)
