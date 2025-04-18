import mysql.connector
import csv

def insert_dataset(csv_path,database_config):
    mydb = mysql.connector.connect(**database_config)
    mycursor = mydb.cursor()
    with open('/Users/yemarnaung/Documents/Final Year/Spring 2025/Introduction to Database System/csc675-775-group-project-sp25-JaredAung/Project/Datasets/Data.csv', 'r') as file:
        csv_reader = csv.reader(file, delimiter=',')
        header = next(csv_reader)  # Read the header row
        # Print the header
        for lines in csv_reader:  # Read the first data row
            # Print each row
            idContent = lines[0]
            type = lines[1]
            title = lines[2]
            director = lines[3]
            cast = lines[4]
            country = lines[5]
            date_added = lines[6]
            release_year = lines[7]
            rating = lines[8]
            duration = lines[9]
            genres = lines[10]
            description = lines[11]

            if director:
                for names in director.split(','):
                    names.strip()
                    if not names: # Skip empty names
                        continue
                    else:
                        mycursor.execute("SELECT idDirector FROM Director WHERE name = %s", (names,))
                        idDirector = mycursor.fetchone()
                        if idDirector is None:
                            mycursor.execute("INSERT INTO Director (name) VALUES (%s)", (names,))
                            mydb.commit()
                            idDirector = mycursor.lastrowid
                    mycursor.execute("INSERT INTO Directed_Content (idContent, idDirector) VALUES (%s, %s)", (idContent, idDirector))



        print(type, title, director, cast, country, date_added, release_year, rating, duration, genres, description)
    # Create a cursor object

    # Execute a query
    mycursor.execute("SELECT * FROM Content")

    # Fetch and print results
    results = mycursor.fetchall()
    for row in results:
        print(row)

    # Optional: Close connection
    mycursor.close()
    mydb.close()

if __name__ == "__main__":
    csv_path = '/Users/yemarnaung/Documents/Final Year/Spring 2025/Introduction to Database System/csc675-775-group-project-sp25-JaredAung/Project/Datasets/Data.csv'
    database_config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'MaThuZar2002$',
        'database': 'MultiMediaDB'
    }
    insert_dataset(csv_path, database_config)