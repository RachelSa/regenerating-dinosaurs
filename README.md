# Using Heroku Scheduler Automate Tasks for Rails 5 Applications

## Tutorial Overview

Some applications need update at set intervals (such as hourly or daily). Heroku, a web application deployment platform, has a free addon which allows developers to set up tasks to run at specified times.

This tutorial uses a demo application with one resource, dinosaurs. Dinosaurs have the following attributes: species, health, happiness, and radiating_positivity. On a daily basis, the application needs to restore each dinosaur's health, happiness, and radiating_positivity to 100 in the database.  

This update is accomplished through a rake task. A rake task is a block of ruby code that can be run from the command line. In the demo app, the rake task with update all dinosaurs in the database with health, happiness, and radiating_positivity attributes set to 100.    

## Part 1: Using the Admin Dashboard, Create a Heroku App with the Heroku Scheduler Add-on

### Requirements

You must have a [Heroku account](https://www.heroku.com/home) to complete this tutorial.

### Instructions
ADD Gif

1. From the [Heroku dashboard](https://dashboard.heroku.com/apps) click the **new** button and select **create new app**.
2. You'll be prompted to name your app. Later, you can give your app a custom domain if you choose. Upon creation, the address will be your-app-name.herokuapp.com.
3. Make sure your region is selected from the dropdown, and click **Create app**.
4. From the dashboard, select the **Overview** tab and click **Configure Add-ons**.
5. Under **Add-ons**, search for **Heroku Scheduler**.
6. Agree to the Terms of Service to add the Scheduler.


### Part 2: Developer Guide to Creating a Rake Task and Configuring on Heroku

### Requirements

This tutorial requires a Rails 5 application with a postgresql database. By default, Rails apps are created with sqlite3 databases, but Heroku requires postgresql. The database can be specified when creating a new rails app: ```rails new app-name --database=postgresql```

<!-- 3. Generate a dinosaur resource.```rails generate scaffold Dinosaur species:string health:integer happiness:integer radiating_positivity:integer```

4. Run the database migration. ```rake db:migrate```

5. Create new dinosaurs to seed the database in `/db/seeds.rb` and run ```rake db:seed```

6. render json for all dinosaurs

7. ```rails s``` -->

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
  - heroku git:remote -a regenerating-dinosaur
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
