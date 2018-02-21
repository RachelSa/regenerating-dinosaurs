# regenerating-dinosaurs

- what is a rake task?

## Project Setup
1. Create a new Rails 5 application with a postgresql database. By default, Rails apps are created with sqlite3 databases, but Heroku requires postgresql, so include the appropriate database flag.
 ```rails new regenerating-dinosaurs --database=postgresql```

2. Navigate to the created project directory ```cd regenerating-dinosaurs```

3. Generate a dinosaur resource.```rails generate scaffold Dinosaur species:string health:integer happiness:integer radiating_positivity:integer```

4. Run the database migration. ```rake db:migrate```

5. Create new dinosaurs to seed the database in `/db/seeds.rb` and run ```rake db:seed```

6. render json for all dinosaurs

7. ```rails s```

////

1. create scheduler.rake file

2. WHY GITHUB NEEDED
If the project is not already on Github:
 - Initialize the project as a Git repository ```git init```.
 - Add all files in the repository for git staging. ```git add .```
 - Commit the files with a message. ```git commit -m "first commit"```
 - Create a repository on Github and add the remote SSH: ```git remote add origin git@github.com:RachelSa/regenerating-dinosaurs.git```
 - Push files up to the remote repository: ```git push -u origin master```

3. WHY HEROKU NEEDED
If the project is not yet hosted on Heroku:
  - Create a Heroku app. ```heroku create```
  - Deploy the code on the master Github repository branch to Heroku ```git push heroku master```
  - Migrate the database on Heroku```heroku run rake db:migrate```
  - Seed the database ```heroku rake db:seed```
  - Ensure a dyno is running the web process```heroku ps:scale web=1```
  - Open the deployed application ```heroku open```  

4. Create the scheduler addon:
  - ```heroku addons:create scheduler:standard```

5. Test that the task runs properly without errors.```heroku run rake restore_dinos```

6. Using Heroku's admin dashboard, schedule the task to run.
https://sheltered-temple-85179.herokuapp.com/dinosaurs
