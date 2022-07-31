## Billing & Recurring Payment System v2.0

This project is basically the implementation of recurrence billing and payment system. There are two user roles[Admin, Buyer]. Admin can manage plans, add features and manage users. Users can visit different plans and subscribe them on monthly basis. I used stripe for payment gateway.

##### 1. Check out the repository

```bash
git clone git@github.com:maaz-shah07/billing-and-payment-system.git
```

##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:setup
```

##### 3. Install gems using bundler

```ruby
Run bundle install
```

<<<<<<< HEAD

##### 4. Start the Rails server

=======

##### 4. Setup database and migrations

```ruby
  rails db:migrate
```

##### 5. Load seed data

```ruby
  rails db:seed
```

##### 6. Start the Rails server

> > > > > > > pagination-branch

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

## Dependencies

```
ruby "2.7.1"
rails, "~> 7.0.2", ">= 7.0.2.3"
carrierwave, '~> 2.0'
bootstrap-sass, '~> 3.3', '>= 3.3.6'
sqlite3, "~> 1.4"
twitter-bootstrap-rails
activestorage-cloudinary-service
bootstrap
carrierwave
client_side_validations
cloudinary
jquery-rails
'pay', '~> 3.0', '>= 3.0.24'
pundit
sidekiq
redis '~> 4.0'
stripe, '~> 5.53'
twitter-bootstrap-rails
sidekiq
sidekiq-cron

```
