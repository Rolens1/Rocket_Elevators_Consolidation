# README

* 1 - HOW TO GET THIS APPLICATION UP AND RUNNING
* 2 - SET UP POSTGRES AS SECOND DATABASE

##  HOW TO GET THIS APPLICATION UP AND RUNNING

* --- Ruby version 
Ruby version required is 2.7.5 to make sure the compatibility is not compromised

* --- System dependencies (Windows)
    - Install WSL 2 
    - Install Ubuntu
    - Install curl to install and compile software packages - If your system is macOS
    - Install rbenv
    - Install rails, version 5.2.6
    - Install MySQL
    - Install postgresql
    - Install pg, nokogiri and others gems

* --- System dependencies (macOS)
    - Install Homebrew to install and compile software packages - If your system is macOS
    - Install rbenv
    - Install rails, version 5.2.6
    - Install MySQL
    - Install postgresql
    - Install pg, nokogiri and others gems

* Configuration
    * --- Git
        - git config --global color.ui true
        - git config --global user.name "YOUR NAME"
        - git config --global user.email "YOUR@EMAIL.com"
        - ssh-keygen -t rsa -C "YOUR@EMAIL.com" 
        - Generate an SSH KEY and add it to your Github account

* Database creation
    - "rake db:create" to create a new database
    -  Put Gem devise in gemfiles
    - "bundle install"
    - "rails g devise:install"

* Database initialization
    - "rails g devise user" (set up the user model)
    - "rake db:migrate"
    - "rake db:seed" (to populate tables with existing data)

* How to run the test suite
    - In your root directory, type "rails s" to lunch the server
    - Run your local server in a browser : http://localhost:3000/

* Deployment instructions
    - Add required gems for the deploy
    - Create specifics files 
        - Cap File
        - Deploy.rb 
        - Production.rb
    - Link your Git
    - Once the sever is set-up with the SSH key and ready ;
        - Make sure your Github main branch is up to date
        - "cap production deploy'
            - Deploy will make an error : database is missing
            - Connect to the SSH server with the right IP
            - Create a files database.yml in the proper folder and right the proper information of the server host
        - "cap production puma:config"
        - "cap production puma:nginx_config"
        - Set up your cloudflare (DNS configuration)

## SET UP POSTGRES AS SECOND DATABASE
* To set up postgres:
    - Make sure you download postgres and have it working on your computer
    - bundle install (if you haven’t done so)
        then ;
    1 - Postgres:db:create
    2 - Postgres:db:migrate
    3 - rake postgres:db:import:fact_quotes
    4 - rake postgres:db:import:fact_contacts
    5 - rake postgres:db:import:fact_elevators
    6 - rake postgres:db:import:dim_customers

* Every time you save new data to our database, and want to include this data in the data warehouse for analysis. Please re-do steps 3-6, or the command for the corresponding table.

* Some other commands for postgres:
    - To create a new migration: 
        rails g postgres_migration create_awesome_table
        rake postgres:db:migrate
    - To drop the database
        rake postgres:db:drop (edited) 

## 

