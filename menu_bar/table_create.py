import pandas as pd
import mysql.connector
from mysql.connector import Error

# Path to your CSV file
csv_file_path = r'C:\Users\jyotsna\PycharmProjects\pythonProject3\menu_items.csv'

# Database connection details
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


def create_table(connection):
    create_table_query = """
    CREATE TABLE IF NOT EXISTS items (
        Item VARCHAR(255),
        Price VARCHAR(255),
        Image VARCHAR(255)
    );
    """
    execute_query(connection, create_table_query)


def insert_data_from_csv(connection, csv_file):
    df = pd.read_csv(csv_file)
    cursor = connection.cursor()
    sql = "INSERT INTO items (Item, Price, Image) VALUES (%s, %s, %s)"
    for i, row in df.iterrows():
        cursor.execute(sql, (row['Item'], row['Price'], row['Image']))

    connection.commit()
    print("Data inserted successfully")


# Establish the connection
connection = create_connection(host, user, password, database)

# Create the table
create_table(connection)

# Insert data from CSV file
insert_data_from_csv(connection, csv_file_path)





