namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    # Need gem to make this work when adding students later: faker
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_girl_rails'

    # Step 1: Create admins and workers
    mark_user = User.new
    mark_user.username = "mark"
    mark_user.password = "secret"
    mark_user.password_confirmation = "secret"
    mark_user.role = "admin"
    mark_user.save!
    mark = Customer.new
    mark.first_name = "Mark"
    mark.last_name = "Heimann"
    mark.email = "mark@razingrooks.org"
    mark.phone = "412-268-2323"
    mark.user_id = mark_user.id
    mark.active = true
    mark.save!

    alex_user = User.new
    alex_user.username = "alex"
    alex_user.password = "secret"
    alex_user.password_confirmation = "secret"
    alex_user.role = "admin"
    alex_user.save!
    alex = Customer.new
    alex.first_name = "Alex"
    alex.last_name = "Heimann"
    alex.email = "alex@razingrooks.org"
    alex.phone = "(412) 268-3259"
    alex.user_id = alex_user.id
    alex.active = true
    alex.save!

    baker_user = User.new
    baker_user.username = "baker"
    baker_user.password = "secret"
    baker_user.password_confirmation = "secret"
    baker_user.role = "baker"
    baker_user.save!
    
    shipper_user = User.new
    shipper_user.username = "shipper"
    shipper_user.password = "secret"
    shipper_user.password_confirmation = "secret"
    shipper_user.role = "shipper"
    shipper_user.save!


    # Step 2: Create some items
    honey_wheat = FactoryGirl.create(:item, 
        name: "Honey Wheat Bread", 
        description: "Our original bread made with stone ground flour, clover honey and a lot of love. This versatile bread is great for toast, sandwiches, formal dinners and just when you need to munch.", 
        units_per_item: 1, 
        category: "bread", 
        weight: 1.0)

    cinnamon_swirl = FactoryGirl.create(:item, 
        name: "Cinnamon Swirl Bread", 
        description: "Your family will be impressed with the soft texture and appealing swirls of cinnamon in these lovely breakfast loaves.", 
        units_per_item: 1, 
        category: "bread", 
        weight: 1.0)

    apple_cherry = FactoryGirl.create(:item, 
        name: "Apple Cherry Bread", 
        description: "A delicious bread made with white flour, dried cherries and dried apples.  This yummy bread makes great holiday gifts for friends and family!", 
        units_per_item: 1, 
        category: "bread", 
        weight: 1.2)

    sourdough = FactoryGirl.create(:item, 
        name: "Sourdough Bread", 
        description: "It is a white bread characterized by a pronounced sourness because the dough is allowed to ferment.  Our style of sourdough is the San Francisco variety, one of the most popular in the world.  Sourdough is popular because of its ability to combine well with seafoods and soups, such as cioppino, clam chowder, and chili.", 
        units_per_item: 1, 
        category: "bread", 
        weight: 1.1)

    challah = FactoryGirl.create(:item, 
        name: "Challah Bread", 
        description: "This is a Jewish egg bread that's braided for a beautiful presentation. We top ours with poppy seeds for a special touch.", 
        units_per_item: 1, 
        category: "bread", 
        weight: 0.9)

    blueberry = FactoryGirl.create(:item, 
        name: "Blueberry Muffins", 
        description: "A dozen of our most popular muffins. We use the same recipie our grandmother did to make her award-winning blueberry muffins.", 
        units_per_item: 12, 
        category: "muffins", 
        weight: 1.0)

    chocolate_zuke = FactoryGirl.create(:item, 
        name: "Chocolate Zucchini Muffins", 
        description: "A tasty recipie our mom used to make to get us to eat our veggies as often as possible with the least complaining possible. Your kids will love them too!", 
        units_per_item: 12, 
        category: "muffins", 
        weight: 1.1)

    apple_carrot = FactoryGirl.create(:item, 
        name: "Apple Carrot Muffins", 
        description: "Another recipie from mom to promote veggies in every meal.  These muffins contain fresh apple bits and shredded carrots.", 
        units_per_item: 12, 
        category: "muffins", 
        weight: 1.1)

    croissants = FactoryGirl.create(:item, 
        name: "Crossiants", 
        description: "A staple of French cuisine, our crossiants are light, fluffy and buttery.", 
        units_per_item: 4, 
        category: "pastries", 
        weight: 1.0)


    breads = [honey_wheat, cinnamon_swirl, apple_cherry, sourdough, challah]
    muffins = [blueberry, chocolate_zuke, apple_carrot]
    pastries = [croissants]
    all_items = breads + muffins + pastries
    breads_and_muffins = breads + muffins

    # Step 3: For each item, create a set of prices
    hw1 = FactoryGirl.create(:item_price, item: honey_wheat, price: 3.95, start_date: 24.months.ago.to_date)
    hw2 = FactoryGirl.create(:item_price, item: honey_wheat, price: 4.25, start_date: 14.months.ago.to_date)
    hw3 = FactoryGirl.create(:item_price, item: honey_wheat, price: 4.75, start_date: 42.weeks.ago.to_date)
    hw4 = FactoryGirl.create(:item_price, item: honey_wheat, price: 4.95, start_date: 6.months.ago.to_date)
    hw5 = FactoryGirl.create(:item_price, item: honey_wheat, price: 5.25, start_date: 4.weeks.ago.to_date)

    cs1 = FactoryGirl.create(:item_price, item: cinnamon_swirl, price: 4.25, start_date: 24.months.ago.to_date)
    cs2 = FactoryGirl.create(:item_price, item: cinnamon_swirl, price: 4.75, start_date: 13.months.ago.to_date)
    cs3 = FactoryGirl.create(:item_price, item: cinnamon_swirl, price: 4.95, start_date: 180.days.ago.to_date)
    cs4 = FactoryGirl.create(:item_price, item: cinnamon_swirl, price: 5.50, start_date: 3.weeks.ago.to_date)

    ac1 = FactoryGirl.create(:item_price, item: apple_cherry, price: 4.95, start_date: 12.months.ago.to_date)
    ac2 = FactoryGirl.create(:item_price, item: apple_cherry, price: 5.95, start_date: 6.months.ago.to_date)
    ac3 = FactoryGirl.create(:item_price, item: apple_cherry, price: 6.95, start_date: 2.weeks.ago.to_date)

    sd1 = FactoryGirl.create(:item_price, item: sourdough, price: 4.25, start_date: 24.months.ago.to_date)
    sd2 = FactoryGirl.create(:item_price, item: sourdough, price: 4.75, start_date: 13.months.ago.to_date)
    sd3 = FactoryGirl.create(:item_price, item: sourdough, price: 4.95, start_date: 180.days.ago.to_date)
    sd4 = FactoryGirl.create(:item_price, item: sourdough, price: 5.50, start_date: 3.weeks.ago.to_date)

    ch1 = FactoryGirl.create(:item_price, item: challah, price: 4.95, start_date: 14.months.ago.to_date)
    ch2 = FactoryGirl.create(:item_price, item: challah, price: 5.50, start_date: 6.months.ago.to_date)
    ch3 = FactoryGirl.create(:item_price, item: challah, price: 5.75, start_date: 14.days.ago.to_date)

    bl1 = FactoryGirl.create(:item_price, item: blueberry, price: 7.95, start_date: 12.months.ago.to_date)
    bl2 = FactoryGirl.create(:item_price, item: blueberry, price: 8.50, start_date: 6.months.ago.to_date)
    bl3 = FactoryGirl.create(:item_price, item: blueberry, price: 8.95, start_date: 2.weeks.ago.to_date)
 
    cz1 = FactoryGirl.create(:item_price, item: chocolate_zuke, price: 7.95, start_date: 12.months.ago.to_date)
    cz2 = FactoryGirl.create(:item_price, item: chocolate_zuke, price: 8.50, start_date: 6.months.ago.to_date)
    cz3 = FactoryGirl.create(:item_price, item: chocolate_zuke, price: 8.95, start_date: 2.weeks.ago.to_date)

    ca1 = FactoryGirl.create(:item_price, item: apple_carrot, price: 7.95, start_date: 12.months.ago.to_date)
    ca2 = FactoryGirl.create(:item_price, item: apple_carrot, price: 8.50, start_date: 6.months.ago.to_date)
    ca3 = FactoryGirl.create(:item_price, item: apple_carrot, price: 8.95, start_date: 2.weeks.ago.to_date)

    cr1 = FactoryGirl.create(:item_price, item: croissants, price: 9.50, start_date: 6.months.ago.to_date)


    # Step 4: Create 120 customers and their associated users
    120.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      this_user = FactoryGirl.create(:user)
      FactoryGirl.create(:customer, user: this_user, first_name: first_name, last_name: last_name)
    end

    all_customers = Customer.all - [mark, alex]

    # Step 5: for each customer associate some addresses
    all_customers.each do |customer|
      billing = FactoryGirl.create(:address, customer: customer, 
        recipient: "#{customer.proper_name}",
        street_1: "#{Faker::Address.street_address}",
        city: "#{Faker::Address.city}",
        state: "#{Address::STATES_LIST.to_h.values.sample}",
        zip: "#{rand(100000).to_s.rjust(5,"0")}",
        is_billing: true)

      if rand(3).zero?
        address_2 = FactoryGirl.create(:address, customer: customer,
          recipient: "James T. Kirk", 
          street_1: "#{Faker::Address.street_address}",
          city: "#{Faker::Address.city}",
          state: "#{Address::STATES_LIST.to_h.values.sample}",
          zip: "#{rand(100000).to_s.rjust(5,"0")}")          
      end

      if rand(4).zero?
        address_3 = FactoryGirl.create(:address, customer: customer, 
          recipient: "Jean Luc Picard",
          street_1: "#{Faker::Address.street_address}",
          street_2: "#{Faker::Address.secondary_address}",
          city: "#{Faker::Address.city}",
          state: "#{Address::STATES_LIST.to_h.values.sample}",
          zip: "#{rand(100000).to_s.rjust(5,"0")}")          
      end
    end
    # Step 6: Create some orders for each customer
    # create credit cards to be used for order payments
    next_year = Date.today.year + 1
    credit_cards = [
      CreditCard.new(4123456789012, next_year, 12),
      CreditCard.new(4123456789012345, next_year, 12),
      CreditCard.new(5123456789012345, next_year, 12),
      CreditCard.new(5412345678901234, next_year, 12),
      CreditCard.new(6512345678901234, next_year, 12),
      CreditCard.new(6011123456789012, next_year, 12),
      CreditCard.new(30012345678901, next_year, 12),
      CreditCard.new(30312345678901, next_year, 12),
      CreditCard.new(341234567890123, next_year, 12),
      CreditCard.new(371234567890123, next_year, 12)
    ]
    all_customers.each do |customer|
      c_address_ids = customer.addresses.map(&:id)
      customer_selections = all_items.shuffle
      [1,1,1,2,2,2,2,3,3,3,3,4,4,5,6,7,9,10,12].sample.times do |i|
      # (1..12).to_a.sample.times do |i|
        order = Order.new
        order.customer_id = customer.id
        order.address_id = c_address_ids.sample
        order.date = (5.months.ago.to_date..2.days.ago.to_date).to_a.sample
        order.save!
        total = 0
        [1,1,2,2,2,3,3,4,5,6].sample.times do |j|
          this_item = customer_selections.pop
          oi = OrderItem.new
          oi.item_id = this_item.id
          oi.order_id = order.id
          oi.quantity = [1,2,3,4].sample
          oi.save!
          total += oi.subtotal(order.date)
        end
        # record total and payment
        total += order.shipping_costs
        order.update_attribute(:grand_total, total)
        # set credit card info
        credit_card = credit_cards.sample
        order.credit_card_number = credit_card.number
        order.expiration_year = credit_card.expiration_year
        order.expiration_month = credit_card.expiration_month
        # pay
        order.pay
        # ship the items
        order.order_items.each{|oi2| oi2.shipped_on = order.date + 1; oi2.save! }
        # reset the selection options
        customer_selections = all_items.shuffle
      end
    end
  end
end