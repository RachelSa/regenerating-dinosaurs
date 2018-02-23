# Using Heroku Scheduler Automate Tasks for Rails 5.x Applications

## Contents
 - [Tutorial Overview](https://github.com/RachelSa/regenerating-dinosaurs#tutorial-overview)
 - [Part 1: Using the Admin Dashboard, Create a Heroku App with the Heroku Scheduler Add-on](https://github.com/RachelSa/regenerating-dinosaurs#part-1-using-the-admin-dashboard-create-a-heroku-app-with-the-heroku-scheduler-add-on)
    - [Creating a Heroku App](https://github.com/RachelSa/regenerating-dinosaurs#creating-a-heroku-app)
    - [Adding the Heroku Scheduler](https://github.com/RachelSa/regenerating-dinosaurs#adding-the-heroku-scheduler)
 - [Part 2: Create a Rake Task and Configure on Heroku](https://github.com/RachelSa/regenerating-dinosaurs#part-2-create-a-rake-task-and-configure-on-heroku)
    - [Creating a Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#creating-a-rake-task)
    - [Pushing to Github and Deploying to Heroku](https://github.com/RachelSa/regenerating-dinosaurs#pushing-to-github-and-deploying-to-heroku)
    - [Testing and Scheduling the Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#testing-and-scheduling-the-rake-task)

## Tutorial Overview

Some applications need tasks to occur at set intervals. Examples of this may include:
  - A daily check for users whose annual subscription needs renewal
  - An hourly update of forecast data for a weather-related app
  - A recalculation of an app's top trending hashtag every ten minutes  

A task is simply an action that can be executed in a code block, such as sending an email to users. A task could also insert, update, or delete information from the application's database.

For Ruby on Rails applications, these tasks are called rake tasks. The ruby code that performs tasks is written in a file with a .rake extension, called a rake file.

This tutorial describes how to run rake tasks for Rails 5.x applications deployed through the Heroku platform. Heroku is a cloud-based web-hosting service used to manage web application deployments.

Heroku has a free add-on called Heroku Scheduler, which is used to handle basic task scheduling. Without a task scheduler, a rake task can be manually run from the command line. With the Heroku Scheduler, a task can be run automatically at specified times.

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


## Part 2: Create a Rake Task and Configure on Heroku

### Description

In order for Heroku Scheduler to run custom rake tasks, a Rails application must have a scheduler.rake file with one or more tasks. This tutorial will show how to add rake tasks to a Rails app, push the code a Heroku app, and schedule the tasks with Heroku Scheduler.

This Github repository contains a demo Rails application with a [rake file](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/lib/tasks/scheduler.rake) containing two tasks. It will be referenced throughout the tutorial.  

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
 - [A Heroku account and Heroku app created with Heroku Scheduler](https://github.com/RachelSa/regenerating-dinosaurs#part-1-using-the-admin-dashboard-create-a-heroku-app-with-the-heroku-scheduler-add-on)

 Before beginning this tutorial, you must have a Rails 5 application stored in a Github repository. Note that in order to deploy on Heroku, the app must have a PostgreSQL database (Rails apps are created with a SQLite database by default).

 If you don't have an existing app, you can [fork and clone](https://help.github.com/articles/fork-a-repo/) this Github repository, which includes a demo app with a rake file. The demo app has one model--dinosaur--and a route, ['/dinosaurs'](https://regenerating-dinosaur.herokuapp.com/dinosaurs), which renders JSON data containing information about all dinosaurs in the database. Checkout the app's [model](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/models/dinosaur.rb), [routes](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/config/routes.rb), and [controller](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/controllers/dinosaurs_controller.rb) to see how this is set up.

### Instructions

#### Creating a Rake Task
1. Within the Rails application, create a new file: ```lib/tasks/scheduler.rake```
2. Within the rakefile, create one or more tasks. A rake task is made up of the following parts:

    * Description (**desc**) explains what the task will do.  
    * The **task** is named (this one is called restore_dinos).
    * **:environment** loads the Rails environment, allowing access to the rest of the Rails app, such as models.
    * Within the **do** block, the task occurs. This example prints a message before calling the `.restore` method on the [Dinosaur model](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/models/dinosaur.rb). After finishing, it prints 'done'.
    * The code block is closed (**end**).

```ruby  
desc "Restore dinosaurs"
task :restore_dinos => :environment do
  puts "Restoring dinos..."
  Dinosaur.restore
  puts "done"
end
```

3. Test the rake task locally by running the command `rake restore_dinos`, replacing `restore_dinos` with your task's name.

### Pushing to Github and Deploying to Heroku
1. Add, commit, and push the code to Github. Code is deployed to Heroku through Github, so the master branch on Github must have created rake file and tasks.  

2. If your app is already deployed to Heroku, simply run the command ```git push heroku master``` and skip to [Testing and Scheduling the Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#testing-and-scheduling-the-rake-task).

Otherwise, deploy the app to Heroku by first running the following command, which connects your repository to the app created on Heroku. Be sure to use the name that you set when creating the app on the Heroku dashboard.  
`heroku git:remote -a your-app-name`

3. Push the code from the Github repository's master branch to Heroku.
  git push heroku master`

4. Migrate the database on Heroku.
  `heroku run rake db:migrate`

5. Seed the database, if applicable.
  `heroku rake db:seed`

6. Heroku apps use **Dynos** to run processes for each deployed application. Dynos run web processes and perform jobs (such as a rake task). When the app is deployed, ensure a Dyno is running web processes.
  `heroku ps:scale web=1`

7. Open the deployed application in browser.
  `heroku open`

See [Heroku documentation](https://devcenter.heroku.com/articles/getting-started-with-rails5) for more information about deployment.

### Testing and Scheduling the Rake Task

1. Test that the task runs properly without errors.
`heroku run rake restore_dinos`

2. The task can be scheduled to run using the app's Heroku dashboard. From the **Overview** dashboard, click **Heroku Scheduler** under **Installed Add-ons**.

3. Click **Add New Job**.

4. Enter the rake command for the task you want to run in the text field.
`rake restore_dinos`

5. Select the frequency you want the task to run from the dropdown.
    - For daily tasks, select the UTC time you want the task to run.
    - For hourly tasks, select the time you next want the task to run.

6. Click **save**.

7. You'll be redirected to the scheduler dashboard, where you can edit or remove the task, or create a new task.

See [Heroku documentation](https://devcenter.heroku.com/articles/scheduler) for more information about Heroku Scheduler.        

## Questions:
 - What do you like about their existing documentation?
 - What would you change about the documentation?
more links
