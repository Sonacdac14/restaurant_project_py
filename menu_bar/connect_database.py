
import pandas as pd
import mysql.connector
from mysql.connector import Error


host = 'localhost'
database = 'my_database'
user = 'root'
password = ''

def create_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            passwd='',
            database=db_name
        )
        print("Connection to MySQL DB successful")
    except Error as e:
        print(f"The error '{e}' occurred")
    return connection

def execute_query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"The error '{e}' occurred")

def select_data(connection):
    select_query = "SELECT * FROM items LIMIT 5"  # retrieve first 5 rows
    cursor = connection.cursor()
    try:
        cursor.execute(select_query)
        rows = cursor.fetchall()
        print("Retrieved data from database:")
        for row in rows:
            print(row)
    except Error as e:
        print(f"The error '{e}' occurred")


connection = create_connection(host, user, password, database)

# Check uploaded CSV data in database
select_data(connection)
