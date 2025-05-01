import mysql.connector
import csv
from datetime import datetime


def insert_dataset(csv_path,database_config):
    mydb = mysql.connector.connect(**database_config)
    mycursor = mydb.cursor()
    with open('/Users/yemarnaung/Documents/Final Year/Spring 2025/Introduction to Database System/csc675-775-group-project-sp25-JaredAung/Project/Datasets/Data.csv', 'r', encoding='utf-8') as file:
        csv_reader = csv.reader(file, delimiter=',')
        header = next(csv_reader)  # Read the header row
        # Print the header
        
        for lines in csv_reader:  # Read the first data row
            # Print each row
            id = lines[0].strip()
            type = lines[1].strip()
            title = lines[2].strip()

            director = lines[3].split(",")
            if director[0] == '':
                director = ['']
            else:
                director = [name.strip() for name in director]
            cast = lines[4].split(",")
            if cast[0] == '':
                cast = ['']
            else:
                cast = [name.strip() for name in cast]
            country = lines[5].strip()
            date_added = lines[6]
            release_year = int(lines[7].strip())
            rating = lines[8].strip()
            duration = lines[9].split()
            if len(duration) == 0:
                duration = 0
            else:
                duration = int(duration[0])
            genres = lines[10].split(",")
            description = lines[11]
            

            #Insert Content
            mycursor.execute("SELECT idContent FROM Content WHERE title = %s", (title,))
            idContent = mycursor.fetchone()
            if idContent: 
                idContent = idContent[0]
                

            if not idContent:
                    #Insert Rating
                if not rating:
                    rating = 'Unrated'
                mycursor.execute("SELECT idRating FROM Rating WHERE name = %s", (rating,))
                idRating = mycursor.fetchone()

                if idRating: idRating = idRating[0]
                
                #Insert Release Year
                if not release_year:
                    mycursor.execute("INSERT INTO Content_Release(idRelease,release_year) VALUES(%s,%s)",(release_year,release_year,))
                    mydb.commit()
                    idRelease = mycursor.lastrowid
                else:
                    mycursor.execute("SELECT idRelease FROM Content_Release WHERE release_year = %s", (release_year,))
                    idRelease = mycursor.fetchone()
                #Handle date format
                if not date_added:
                    date_added_str = '2025-04-26-00:00:00'
                else:
                    date_added_obj = datetime.strptime(date_added.strip(),'%B %d, %Y')
                    date_added_str = date_added_obj.strftime('%Y-%m-%d')
                print(title + " Inserted")
                mycursor.execute(
                    "INSERT INTO Content(title, type, idRating, idRelease, date_added,description) VALUES (%s, %s, %s, %s, %s,%s)",
                    (title, type, idRating, idRelease, date_added_str,description))
                mydb.commit()
                idContent = mycursor.lastrowid

                #INSERT Movie/Show
                if type == 'Movie':
                    mycursor.execute("SELECT idContent FROM Movie WHERE idContent = %s", (idContent,))
                    idMovie = mycursor.fetchone()
                    if not idMovie:
                        mycursor.execute("INSERT IGNORE INTO Movie(idContent,duration) VALUES (%s,%s)",(idContent,duration))
                        mydb.commit()
                elif type == 'TV Show':
                    mycursor.execute("SELECT idContent FROM `Show` WHERE idContent = %s", (idContent,))
                    idShow = mycursor.fetchone()
                    if not idShow:
                        mycursor.execute("INSERT IGNORE INTO `Show` (idContent, duration) VALUES (%s,%s)",(idContent,duration))
                        mydb.commit()

            #Insert Directors
            for i in range(len(director)):
                mycursor.execute("SELECT idDirector FROM Director WHERE name =%s",(director[i],))
                idDirector = mycursor.fetchone()
                if idDirector: 
                    idDirector = idDirector[0]
                else:
                    mycursor.execute("INSERT INTO Director(name)VALUE(%s)", (director[i],))
                    mydb.commit()
                    idDirector = mycursor.lastrowid
                
                mycursor.execute("INSERT IGNORE INTO Directed_Content (idDirector, idContent) VALUES (%s, %s)", (idDirector, idContent))

            #Insert Cast
            for i in range(len(cast)):
                mycursor.execute("SELECT idActors FROM Actor WHERE name = %s",(cast[i],))
                idActor = mycursor.fetchone()
                if idActor:
                    idActor = idActor[0]
                else:
                    mycursor.execute("INSERT INTO Actor(name) VALUE (%s)", (cast[i],))
                    mydb.commit()
                    idActor = mycursor.lastrowid

                mycursor.execute("INSERT IGNORE INTO Content_Cast (idActor, idContent) VALUES (%s,%s)",(idActor,idContent))

            #Insert Country
            mycursor.execute("SELECT idCountry FROM Country WHERE name = %s", (country,))
            idCountry = mycursor.fetchone()
            if idCountry:
                idCountry = idCountry[0]
            else:
                mycursor.execute("INSERT IGNORE INTO Country(name) VALUE (%s)", (country,))
                mydb.commit()
                idCountry = mycursor.lastrowid
            mycursor.execute("INSERT IGNORE INTO CountryContent (idCountry, idContent) VALUES (%s,%s)",(idCountry,idContent))
            #Insert Genre
            for i in range(len(genres)):
                mycursor.execute("SELECT idGenre FROM Genre WHERE name = %s", (genres[i].strip(),))
                idGenre = mycursor.fetchone()
                if idGenre: idGenre = idGenre[0]
                else:
                    mycursor.execute("INSERT INTO Genre(name) VALUE (%s)", (genres[i].strip(),))
                    mydb.commit()
                    idGenre = mycursor.lastrowid
                mycursor.execute("INSERT IGNORE INTO Content_Genre (idGenre, idContent) VALUES (%s,%s)",(idGenre,idContent))
            
           
            
        
        

            


    

if __name__ == "__main__":
    csv_path = '/Users/yemarnaung/Documents/Final Year/Spring 2025/Introduction to Database System/csc675-775-group-project-sp25-JaredAung/Project/Datasets/Data.csv'
    database_config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'MaThuZar2002$',
        'database': 'MultiMediaDB'
    }
    insert_dataset(csv_path, database_config)