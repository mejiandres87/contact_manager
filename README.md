# README

This is the MVP prototype RoR project of a contact manager (importer from csv).

## Dependencies and Technology Stack

The project is developed in Ruby (v 2.6.9) on Rails (v 6.1.4.4) with MiniTest as the testing framework.

For the asynchronous processing of files is made using `:sidekiq` with	`redis` as the queue.

`Bootstrap 4` was used a front end framework for styling, installed using `yarn`.

Since this is a proof of concept, `sqlite` was used as the database, managed by the `sqlite3` gem.

Also, `devise` gem was used the user management, `devise-bootstrap-views` for styling devise views, `credit_card_validations` provided the credit card validation helpers and `will_paginate` gem helpers were used to paginate data.

## Installing and running

As you clone this repository make sure to install all RoR dependencies by running on the root of the project the following command

```
bundle install
```

Afterwards, make sure to install the front end dependencies by running this, also, on the root of the project

```
yarn install
```

Lastly, run the migrations in order to have the database prepared for the application by using this command

```
rails db:migrate
```

### Running tests

To run all unit tests just execute the following command on the project root

```
rails test
```

### Running the application

#### Running dependencies

Since `redis` is a dependency for this project, make sure you have it installed and running on the default port **6379**.

You can either, download it from the official page [download link](https://redis.io/download). Or, if you use docker you can run this command:

```
docker run --name redis-instance -p 6379:6379 -d redis
```

That command should start a redis instance on the background listening to the default redis port.

Now, for the workers to be executed you must initialize `sidekiq`, it should be running, so execute the next command at the root of the project

```
bundle exec sidekiq
```

#### Running the project

At the project root, run the command

```
rails s
```

And then, using your internet browser, go to [http://localhost:3000].

You can register as a new user by pressing the Sign up button or, if you are already registered, you can login using your credentials (email and password).

Then you should be redirected to a Contacts table where you can see all the contacts the user imported, showing 10 records at a time.

You can also navigate to the files importer section by pressing the corresponding button or going to [http://localhost:3000/contacts_files]. This will also, present a paginated table of all the uploaded files with their respective status, successfully imported records, importing failures and a couple of actions, show and import.

The show action will give a description of the state of the import, detailing the status and if any errors ocurred while importing the file, it will display the source line from the file and the errors asociated to it.

The import action will queue the file import process that will be handled on the background. A couple of files are provided within the project `contacts_ok.csv` and `contacts_fail.csv`. 

Be sure to import first `contacts_ok.csv`, otherwise, one case from `contacts_fail.csv` won't fail, since it is the validation of non repeated contact emails per user.

### IMPORTANT NOTES
As per this commit a bug was detected where the upload file form do not refresh the filename input when the file is selected on the open file dialog. The issue was reported on the project's github page.

Additionally, the funtionality to map headers from the csv file was not develop due to the time restriction.