# Using Heroku Scheduler Automate Tasks for Rails 5 Applications

## Tutorial Overview

Some applications need tasks to occur at set intervals (such as hourly or daily). Examples of this may include:
  - A daily check for users whose annual account needs renewal
  - An hourly update of forecast data for a weather-related app
  - A calculation of an app's top trending hashtag every ten minutes  

A task simply performs an action, such as sending an email to users. A task could also insert, update, or delete information from the database.

For Ruby on Rails applications, these tasks are called rake tasks. The ruby code that performs tasks is written in a file called the rakefile.

This tutorial describes how to run rake tasks for Rails 5 applications deployed through the Heroku platform. Heroku is a cloud-based web-hosting service, used to manage web application deployments.

Heroku has a free Heroku add-on to handle basic task scheduling. Without a task scheduler, a rake task can be manually run from the command line. With the Heroku Scheduler, a task can be run automatically at specified times.

## Part 1: Using the Admin Dashboard, Create a Heroku App with the Heroku Scheduler Add-on

### Description
Heroku Scheduler is a free Heroku add-on that runs tasks at specific intervals. Tasks can be run daily, hourly, or every ten minutes with Scheduler. Daily tasks are set to run at a specified UTC time.

Through Heroku's admin dashboard, Scheduler can be added to an app, and tasks can be scheduled. This tutorial shows how to create a new Heroku project and add the Scheduler.

### Intended Audience

Admin user (non-developer)

### Requirements

You must have a [Heroku account](https://www.heroku.com/home) to complete this tutorial.

### Instructions

#### Creating a Heroku App
1. From the [Heroku dashboard](https://dashboard.heroku.com/apps) click the **new** button and select **create new app**.
2. You'll be prompted to name your app. After creating the app, you can provide a custom domain if you choose. Otherwise, your app will be hosted at your-app-name.herokuapp.com.
3. Make sure your region is selected from the dropdown, and click **Create app**.

#### Adding the Heroku Scheduler
1. From the dashboard, select the **Overview** tab and click **Configure Add-ons**.
2. Under **Add-ons**, search for **Heroku Scheduler**.
3. Agree to the Terms of Service to add the Scheduler.
4. On the app's dashboard, the Scheduler will be visible under **Installed add-ons**.


## Part 2: Developer Guide to Creating a Rake Task and Configuring on Heroku

### Requirements
The following must be installed:
 - Ruby version 2.4.1
 - Rails ~5.1.5
 - [Heroku CLI developer tools](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
 - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
 - [PostgreSQL](https://www.postgresql.org/download/)

Also required:
 - [Github](https://github.com/) account
 - A Heroku account and app created with Heroku Scheduler (see previous tutorial)

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
