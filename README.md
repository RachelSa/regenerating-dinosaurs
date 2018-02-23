# Using Heroku Scheduler Automate Tasks for Rails 5 Applications

## Tutorial Overview

Some applications need tasks to occur at set intervals. Examples of this may include:
  - A daily check for users whose annual subscription needs renewal
  - An hourly update of forecast data for a weather-related app
  - A recalculation of an app's top trending hashtag every ten minutes  

A task is simply an action that can be executed in a code block, such as sending an email to users. A task could also insert, update, or delete information from the application's database.

For Ruby on Rails applications, these tasks are called rake tasks. The ruby code that performs tasks is written in a file with a .rake extension, called a rake file.

This tutorial describes how to run rake tasks for Rails 5 applications deployed through the Heroku platform. Heroku is a cloud-based web-hosting service, used to manage web application deployments.

Heroku has a free add-on to handle basic task scheduling called Heroku Scheduler. Without a task scheduler, a rake task can be manually run from the command line. With the Heroku Scheduler, a task can be run automatically at specified times.

## Part 1: Using the Admin Dashboard, Create a Heroku App with the Heroku Scheduler Add-on

### Description

Heroku Scheduler is a free Heroku add-on that runs tasks at specific intervals. Tasks can be run daily, hourly, or every ten minutes with the Scheduler. Daily tasks are set to run at a specified UTC time.

Through Heroku's admin dashboard, Scheduler can be added to an app, and tasks can be scheduled. This tutorial shows how to create a new Heroku project and add the Scheduler.

### Intended Audience

Web application admin (non-developer)

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
3. Upon selecting the Scheduler, agree to the Terms of Service.
4. The Scheduler will be added and in the **Overview** dashboard, the Scheduler will be visible under **Installed add-ons**.


## Part 2: Developer Guide to Creating a Rake Task and Configuring on Heroku

### Description

This tutorial will show how to write a custom rake task in a rake file and run the task with Heroku Scheduler. This Github repository contains a demo Rails application and specific files within the app will be referenced throughout the tutorial.  

### Intended Audience
Ruby on Rails Developer

### Requirements
The following must be installed:
 - [Ruby version 2.4.1](https://www.ruby-lang.org/en/documentation/installation/)
 - [Rails ~5.1.5](http://rubyonrails.org/)
 - [Heroku CLI developer tools](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
 - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
 - [PostgreSQL](https://www.postgresql.org/download/)

Also required:
 - [Github account](https://github.com/)
 - A Heroku account and Heroku app created with Heroku Scheduler (see previous tutorial)

 Before beginning this tutorial, you must have a Rails 5 application deployed on Heroku. If you don't have an existing app, you can fork and clone this Github repository or generate a new Rails application with a PostgreSQL database (Heroku requires a PostgreSQL database) using the Rails generator command:

   ```rails new app-name --database=postgresql```

 If you've created a new Rails application, you'll need to create resource in the database in order to test that the rake task is working. The demo app has one model--dinosaur--and a route, ['/dinosaurs'](https://regenerating-dinosaur.herokuapp.com/dinosaurs), which renders JSON data containing information about all dinosaurs in the database.

### Instructions

#### Creating a Rake Task
1. Within the Rails application, create a new file: ```lib/tasks/scheduler.rake```
2. Within the rakefile, create one or more tasks. A rake task is made up of the following parts:

  ⋅⋅* Description (**desc**) explains what the task will do.  
  ⋅⋅* The **task** is named (this one is called restore_dinos).
  ⋅⋅* **:environment** loads the Rails environment, allowing access to the rest of the Rails app, such as models.
  ⋅⋅* Within the **do** block, the task occurs. This example prints a message before calling the `.restore` method on the Dinosaur model. After finishing, it prints 'done'.
  ⋅⋅* The code block is closed (**end**).

```ruby  
desc "Restore dinosaurs"
task :restore_dinos => :environment do
  puts "Restoring dinos..."
  Dinosaur.restore
  puts "done"
end
```

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


5. Test that the task runs properly without errors.```heroku run rake restore_dinos```

6. Using Heroku's admin dashboard, schedule the task to run.
https://sheltered-temple-85179.herokuapp.com/dinosaurs
