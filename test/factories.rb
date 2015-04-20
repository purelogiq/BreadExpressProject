FactoryGirl.define do
  factory :item do
    name "Honey Wheat Bread"
    description "A most tasty treat from the bakers at Bread Express. Your family will love it!"
    picture nil
    category "bread"
    units_per_item 1
    weight 1.0
    active true
  end

  factory :item_price do
    association :item
    price 1.00
    start_date Date.today
    end_date nil
  end
  
  factory :user do
    sequence :username do |n|
      "user#{n}"
    end
    password "secret"
    password_confirmation "secret"
    role "customer"
    active true
  end

  factory :customer do
    first_name "Ed"
    last_name "Gruberman"
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    email { |u| "#{u.first_name[0]}#{u.last_name}#{(1..99).to_a.sample}@example.com".downcase }
    association :user
    active true
  end

  factory :address do
    recipient "Ted Gruberman"
    street_1 "5000 Forbes Avenue"
    street_2 nil
    city "Pittsburgh"
    state "PA"
    zip "15213"
    association :customer
    is_billing false
    active true
  end

  factory :order do
    date Date.today
    association :customer
    association :address
    grand_total 0.00
    credit_card_number "4123456789012345"
    expiration_year 1.year.from_now.year
    expiration_month 12
    payment_receipt nil
  end

  factory :order_item do
    shipped_on nil
    association :order
    association :item
    quantity 1
  end

end