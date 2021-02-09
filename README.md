### Project Setup

 1. Clone the Project:
 ```sh
git clone git@github.com:iamjunaidali/calendar-api.git
cd calendar-api
```
2. Bundle install
    + `bundle install`
6. Run Data Migrations
    + `rails db:setup db:migrate`

Technologies:
- Ruby version (2.7.1)
- PostgreSQL (12.4)
- Sidekiq
* Testing with:
    - Rspec
    - Rspec Sidekiq
    - Shoulda matchers
    - Database cleaner
    - Faker
