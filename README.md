# Using Heroku Scheduler Automate Tasks for Rails 5.x Applications

## Contents
 - [Tutorial Overview](https://github.com/RachelSa/regenerating-dinosaurs#tutorial-overview)
 - [Part 1: Create a Heroku App with the Heroku Scheduler Add-on](https://github.com/RachelSa/regenerating-dinosaurs#part-1-create-a-heroku-app-with-the-heroku-scheduler-add-on)
    - [Creating a Heroku App](https://github.com/RachelSa/regenerating-dinosaurs#creating-a-heroku-app)
    - [Adding the Heroku Scheduler](https://github.com/RachelSa/regenerating-dinosaurs#adding-the-heroku-scheduler)
 - [Part 2: Create a Scheduled Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#part-2-create-a-scheduled-rake-task)
    - [Creating a Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#creating-a-rake-task)
    - [Pushing to Github and Deploying to Heroku](https://github.com/RachelSa/regenerating-dinosaurs#pushing-to-github-and-deploying-to-heroku)
    - [Testing and Scheduling the Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#testing-and-scheduling-the-rake-task)
 - [Reference of Terms](https://github.com/RachelSa/regenerating-dinosaurs#reference-of-terms)

## Tutorial Overview

Some applications need tasks to occur at set intervals. Examples of this may include:
  - A daily email update to active users
  - An hourly update of forecast data for a weather-related app
  - A recalculation of an application's top trending hashtag every ten minutes  

A task is a subroutine, a set of instructions to perform a job. The task could be a read or write to the application's database, a request to an API, or any job that can be routinely executed by code.

Ruby on Rails applications have a task management tool called Rake. Rake tasks are written in a file with a .rake extension, called a Rake file. They can be run with the command `rake <task_name>`, i.e.: `rake send_renewal_reminders`.

This tutorial describes how to run Rake tasks for Rails 5.x applications deployed through the Heroku platform. Heroku is a cloud-based web-hosting service used to manage web application deployments.

Heroku has a free add-on called Heroku Scheduler, which is used to handle basic task scheduling. Without a task scheduler, a Rake task can be manually run from the command line. With the Heroku Scheduler, a task can be run automatically at specified times.

**Notes about Heroku Scheduler**:
  - Tasks can only be run daily, hourly, or every ten minutes with Scheduler. For cases where different time intervals are needed, use a [custom clock process](https://devcenter.heroku.com/articles/scheduled-jobs-custom-clock-processes).
  - In rare cases, jobs scheduled with Heroku Scheduler may be skipped or run twice. Check Heroku's documentation for [alternatives and task monitoring options](https://devcenter.heroku.com/articles/scheduler#known-issues-and-alternatives).  

## Part 1: Create a Heroku App with the Heroku Scheduler Add-on

### Description

Through Heroku's admin dashboard, Scheduler can be added to an app, and tasks can be scheduled. This tutorial shows how to create a new Heroku project and add Scheduler.

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
3. Upon selecting **Heroku Scheduler**, agree to the Terms of Service.
4. **Scheduler** will be added and in the **Overview** dashboard, **Scheduler** will be visible under **Installed add-ons**.


## Part 2: Create a Scheduled Rake Task

### Description

In order for Heroku Scheduler to run custom Rake tasks, a Rails application must have one or more predefined tasks. This tutorial shows how to add Rake tasks to a Rails app, push the code a Heroku app, and schedule the tasks with Heroku Scheduler.

This Github repository contains a demo Rails application with a [rake file](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/lib/tasks/scheduler.rake) containing two tasks, which will be referenced throughout the tutorial.  

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

 Before beginning this tutorial, you must have a Rails 5 application with a Github repository. Note that in order to deploy on Heroku, the app must have a PostgreSQL database (Rails apps are created with a sqlite3 database by default).

 If you don't have an existing app, you can [fork and clone](https://help.github.com/articles/fork-a-repo/) this Github repository, which includes a demo app with a rake file. The demo app has one model `dinosaur` and a route, ['/dinosaurs'](https://regenerating-dinosaur.herokuapp.com/dinosaurs), which renders JSON data containing information about all dinosaurs in the database. Check the app's [model](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/models/dinosaur.rb), [routes](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/config/routes.rb), and [controller](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/controllers/dinosaurs_controller.rb) to see how this is set up.

### Instructions

#### Creating a Rake Task
1. Within the Rails application, create a new file: ```lib/tasks/scheduler.rake```
2. Within the rakefile, create one or more tasks.

```ruby  
desc "Restore dinosaurs"
task :restore_dinos => :environment do
  puts "Restoring dinos..."
  Dinosaur.restore
  puts "done"
end
```

A rake task is made up of the following parts:
  - `desc <task_description>` explains what the task will do.  
  - `task <:symbolized_task_name>` names the task. (This one is called restore_dinos.)
  - `=> :environment` loads the entire Rails app by default, giving access to models, etc.
  - The task is written within the code block. This example prints a message before calling the `.restore` method on the [Dinosaur model](https://github.com/RachelSa/regenerating-dinosaurs/blob/master/app/models/dinosaur.rb). After finishing, it prints 'done'.

3. Test the rake task locally by running the command `rake <task-name>`.

### Pushing to Github and Deploying to Heroku
1. `Add`, `commit`, and `push` the code to Github. Code is deployed to Heroku through Github, so the Github repository must have a deployment-ready branch (in this case the master branch) to push to Heroku.  

2. If your app is already deployed to Heroku, simply run the command ```git push heroku master``` and skip to [Testing and Scheduling the Rake Task](https://github.com/RachelSa/regenerating-dinosaurs#testing-and-scheduling-the-rake-task).

Otherwise, deploy the app to Heroku by first running the following command, which connects your repository to the app created on Heroku. Be sure to use the name that you set when creating the app on the Heroku dashboard.  
`heroku git:remote -a your-app-name`

3. Push the code from the Github repository's master branch to Heroku.
  `git push heroku master`

4. Migrate the database on Heroku.
  `heroku run rake db:migrate`

5. Seed the database, if applicable.
  `heroku rake db:seed`

6. Heroku apps use **Dynos** to run processes for each deployed application. **Dynos** run web processes and perform jobs (such as a Rake task). When the app is deployed, ensure a **Dyno** is running the web processes.
  `heroku ps:scale web=1`

7. Open the application in browser to confirm the deployment worked.
  `heroku open`

See [Heroku documentation](https://devcenter.heroku.com/articles/getting-started-with-rails5) for more information about deployment.

### Testing and Scheduling the Rake Task

1. Test that the task runs properly on Heroku without errors.
`heroku run rake restore_dinos`

2. The task can be scheduled to run using the app's Heroku dashboard. From the **Overview** dashboard, click **Heroku Scheduler** under **Installed Add-ons**.

3. Click **Add New Job**.

4. Enter the `rake` command for the task you want to run in the text field.
`rake restore_dinos`

5. Select the frequency you want the task to run from the dropdown.
    - For daily tasks, select the UTC time you want the task to run.
    - For hourly tasks, select the minutes on the hour you want the task to run.

6. Click **save**.

7. You'll be redirected to the scheduler dashboard, where you can edit or remove the task, or create a new task.

See [Heroku documentation](https://devcenter.heroku.com/articles/scheduler) for more information about Heroku Scheduler.    

## Reference of Terms

**Dynos**: containers used to run web processes and perform jobs for apps deployed through Heroku

**Git**: a version control system used widely in software development

**Github**: a web-hosted Git version control system  

**Heroku**: a cloud-based web-hosting service used to manage web application deployments

**Heroku Scheduler**: a free Heroku add-on used to handle basic task scheduling

**PostgreSQL**: an object-relational database system

**Rake task**: a Ruby sub-routine written in a Rake file

**Ruby on Rails**: a web application framework with a model-view-controller structure


## Questions:
What do you like about their existing documentation?
  - Readable; no unnecessary jargon
  - Copy and paste code snippets and commands
  - Includes steps to confirm everything is working properly
  - Includes timestamp of last update

What would you change about the documentation?
  - No quick reference of Heroku commands
  - Scrolling / no sidebar or stikcy TOC
  - Documentation sidebar navigation topics are too broad to browse
  - Relevant language-related tutorials should be more available
