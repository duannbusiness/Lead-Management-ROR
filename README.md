##### Prerequisites
The setups steps expect following tools installed on the system.
Ruby [2.6.6]
Rails [5.2.4.4]
postgres [13.0 ]
##### 1. Check out the repository
```bash
https://github.com/duannbusiness/Lead-Management-ROR.git
```
##### 2. Create database.yml file
Copy the sample database.yml file and edit the database configuration as required.
```bash
cp config/database.yml.sample config/database.yml
```
##### 3. Create and setup the database
Run the following commands to create and setup the database.
```ruby
rails db:setup
rails db:migrate
rails db:seed
```
##### 4. Start the Rails server
Change application.yml to set enviroment variable
```ruby
rails s
```
##### 5. Start the Rails server
You can start the rails server using the command given below.
```ruby
rails s
```
And now you can visit the site with the URL http://localhost:3000