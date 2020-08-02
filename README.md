## Bread Express ##

It is a mockup pastry store site built with Ruby on Rails that allows users
to sign up and order delicous pastries and also allows the administrator to manage inventory,
orders, customers, and employees.

![Screenshot 1](https://github.com/purelogiq/BreadExpressProject/raw/master/screenshots/breadexpress-shop.png)
![Screenshot 2](https://github.com/purelogiq/BreadExpressProject/raw/master/screenshots/breadexpress-cart.png)
![Screenshot 3](https://github.com/purelogiq/BreadExpressProject/raw/master/screenshots/breadexpress-checkout.png)


### Setup ###

1. Clone the repo
2. Run `bundle install`
3. Run `rake db:migrate db:populate`
  - This will setup the database with 120 customers, 9 items to buy, and 600 orders.
4. Run rails server and navigate to http://localhost:3000 (by default)
5. Login with a regular user account: *username*: user1, *password*: secret (username goes up to user120)
6. Login with an admin account: *username*: mark, *password*: secret. From here you can see the other employee accounts, all passwords are `secret`.

### Features ###
This site demonstrates...

- Solid database design skills
- Good separation of model, view, and controller concerns.
- Test driven development.
- Good site design/user experience.

### Improvments ###
- I would have like to have made more use of javascript to improve the user experience.
- I wanted to add some statistics/reporting to the administrator home page but ran out of time.
- Saving a user's session (and cart) to the database.
