# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Movie.destroy_all 
Studio.destroy_all
Actor.destroy_all
Role.destroy_all 

# Generate models and tables, according to the domain model.

#I ran the following prompts in the terminal to do so: 
#rails generate model Movie 
#rails generate model Studio 
#rails generate model Actor 
#rails generate model Role 


#Then I ran the migration with this prompt in the terminate: rails db:migrate 
#This was in order to execute the migration tables, so I could then start filling in data 

# Insert data into the database that reflects the sample data shown above. Do not use hard-coded foreign key IDs.

#I started by populating the Studio table 

studio = Studio.new
studio["name"] = "Warner Bros."
studio.save

#Then I populated the Actor table 
actor = Actor.new 
actor["name"] = "Christian Bale"
actor.save

actor = Actor.new 
actor["name"] = "Michael Caine"
actor.save

actor = Actor.new 
actor["name"] = "Liam Neeson"
actor.save

actor = Actor.new 
actor["name"] = "Katie Holmes"
actor.save

actor = Actor.new 
actor["name"] = "Gary Oldman"
actor.save

actor = Actor.new 
actor["name"] = "Heath Ledger"
actor.save

actor = Actor.new 
actor["name"] = "Aaron Eckhart"
actor.save

actor = Actor.new 
actor["name"] = "Maggie Gyllenhaal"
actor.save

actor = Actor.new 
actor["name"] = "Tom Hardy"
actor.save

actor = Actor.new 
actor["name"] = "Joseph Gordon-Levitt"
actor.save

actor = Actor.new 
actor["name"] = "Anne Hathaway"
actor.save

#I created a query to find the studio name within the studio table 
warner = Studio.find_by({"name" => "Warner Bros."})

#I then populated the Movie table 
movie = Movie.new
movie["name"] = "Batman Begins"
movie["year_released"] = "2005"
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save 

movie = Movie.new
movie["name"] = "The Dark Knight"
movie["year_released"] = "2008"
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save 

movie = Movie.new
movie["name"] = "The Dark Knight Rises"
movie["year_released"] = "2012"
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save 

#puts movie.inspect

#I then queried to find a movie within the Movie Table 
batman = Movie.find_by({"name" => "Batman Begins"})
knight = Movie.find_by({"name" => "The Dark Knight"})
knightrises = Movie.find_by({"name" => "The Dark Knight Rises"})

#Query to find the actors within the Actor Table 
christian = Actor.find_by({"name" => "Christian Bale"})
michael = Actor.find_by({"name" => "Michael Caine"})
liam = Actor.find_by({"name" => "Liam Neeson"})
katie = Actor.find_by({"name" => "Katie Holmes"})
gary =  Actor.find_by({"name" => "Gary Oldman"})

#you'll need to do this for the remaining actors 

#Populate the Roles table 

role = Role.new
role["character_name"] = "Alfred"
role["movie_id"] = batman["id"]
role["actor_id"] = michael["id"]
role.save 

role = Role.new
role["character_name"] = "Bruce Wayne"
role["movie_id"] = batman["id"]
role["actor_id"] = christian["id"]
role.save 

role = Role.new
role["character_name"] = "Ra's Al Ghul"
role["movie_id"] = batman["id"]
role["actor_id"] = liam["id"]
role.save 

#you'll need to do this for the remaining characters
# how do I deal with a character appearing in more than one movie?

# Query the movies data and loop through the results to display the movies output.
# TODO!

# Prints a header for the movies output & display Movies
puts "Movies"
puts "======"
puts ""

allbatmans = Movie.all
# loop through array of movie rows 
for movie in allbatmans
  # read the relevant columns from the movie row
  movie_name = movie["name"]
  year = movie["year_released"]
  rating = movie["rated"]
  studio = Studio.find_by({"id" => movie["studio_id"]})
  studio_name = studio["name"]

  # display a string with the relevant columns
  puts "#{movie_name} #{year} #{rating} #{studio_name}"
end


##{studio_name}
# Prints a header for the cast output
#puts ""
#puts "Top Cast"
#puts "========"
#puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!
