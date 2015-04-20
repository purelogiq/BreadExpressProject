module Contexts
  module ItemPrices
    # Context for item_prices (assumes item context)
    def create_item_prices
      create_bread_prices
      create_muffin_prices
      create_pastry_prices
    end
    
    def destroy_item_prices
      destroy_bread_prices
      destroy_muffin_prices
      destroy_pastry_prices
    end

    def create_bread_prices
      @hw1 = FactoryGirl.create(:item_price, item: @honey_wheat, price: 3.95, start_date: 24.months.ago.to_date)
      @hw2 = FactoryGirl.create(:item_price, item: @honey_wheat, price: 4.25, start_date: 14.months.ago.to_date)
      @hw3 = FactoryGirl.create(:item_price, item: @honey_wheat, price: 4.75, start_date: 42.weeks.ago.to_date)
      @hw4 = FactoryGirl.create(:item_price, item: @honey_wheat, price: 4.95, start_date: 6.months.ago.to_date)
      @hw5 = FactoryGirl.create(:item_price, item: @honey_wheat, price: 5.25, start_date: 4.weeks.ago.to_date)

      @cs1 = FactoryGirl.create(:item_price, item: @cinnamon_swirl, price: 4.25, start_date: 24.months.ago.to_date)
      @cs2 = FactoryGirl.create(:item_price, item: @cinnamon_swirl, price: 4.75, start_date: 13.months.ago.to_date)
      @cs3 = FactoryGirl.create(:item_price, item: @cinnamon_swirl, price: 4.95, start_date: 180.days.ago.to_date)
      @cs4 = FactoryGirl.create(:item_price, item: @cinnamon_swirl, price: 5.50, start_date: 3.weeks.ago.to_date)

      # @ac1 = FactoryGirl.create(:item_price, item: @apple_cherry, price: 4.95, start_date: 12.months.ago.to_date)
      # @ac2 = FactoryGirl.create(:item_price, item: @apple_cherry, price: 5.95, start_date: 6.months.ago.to_date)
      # @ac3 = FactoryGirl.create(:item_price, item: @apple_cherry, price: 6.95, start_date: 2.weeks.ago.to_date)

      @sd1 = FactoryGirl.create(:item_price, item: @sourdough, price: 4.25, start_date: 24.months.ago.to_date)
      @sd2 = FactoryGirl.create(:item_price, item: @sourdough, price: 4.75, start_date: 13.months.ago.to_date)
      @sd3 = FactoryGirl.create(:item_price, item: @sourdough, price: 4.95, start_date: 180.days.ago.to_date)
      @sd4 = FactoryGirl.create(:item_price, item: @sourdough, price: 5.50, start_date: 3.weeks.ago.to_date)

      @ch1 = FactoryGirl.create(:item_price, item: @challah, price: 4.95, start_date: 14.months.ago.to_date)
      @ch2 = FactoryGirl.create(:item_price, item: @challah, price: 5.50, start_date: 6.months.ago.to_date)
      @ch3 = FactoryGirl.create(:item_price, item: @challah, price: 5.75, start_date: 14.days.ago.to_date)
    end

    def create_muffin_prices
      @cz1 = FactoryGirl.create(:item_price, item: @chocolate_zuke, price: 7.95, start_date: 12.months.ago.to_date)
      @cz2 = FactoryGirl.create(:item_price, item: @chocolate_zuke, price: 8.50, start_date: 6.months.ago.to_date)
      @cz3 = FactoryGirl.create(:item_price, item: @chocolate_zuke, price: 9.25, start_date: 2.weeks.ago.to_date)

      @bl1 = FactoryGirl.create(:item_price, item: @blueberry, price: 7.95, start_date: 12.months.ago.to_date)
      @bl2 = FactoryGirl.create(:item_price, item: @blueberry, price: 8.50, start_date: 6.months.ago.to_date)
      @bl3 = FactoryGirl.create(:item_price, item: @blueberry, price: 8.95, start_date: 1.weeks.ago.to_date)
    
      # @ca1 = FactoryGirl.create(:item_price, item: @apple_carrot, price: 7.95, start_date: 12.months.ago.to_date)
      # @ca2 = FactoryGirl.create(:item_price, item: @apple_carrot, price: 8.50, start_date: 6.months.ago.to_date)
      # @ca3 = FactoryGirl.create(:item_price, item: @apple_carrot, price: 8.95, start_date: 2.weeks.ago.to_date)
    end

    def create_pastry_prices
      @cr1 = FactoryGirl.create(:item_price, item: @croissants, price: 9.50, start_date: 6.months.ago.to_date)
    end

    def destroy_bread_prices
      @hw1.delete
      @hw2.delete
      @hw3.delete
      @hw4.delete
      @hw5.delete
      @cs1.delete
      @cs2.delete
      @cs3.delete
      @cs4.delete
      # @ac1.delete
      # @ac2.delete
      # @ac3.delete
      @sd1.delete
      @sd2.delete
      @sd3.delete
      @sd4.delete
      @ch1.delete
      @ch2.delete
      @ch3.delete
    end

    def destroy_muffin_prices
      @bl1.delete
      @bl2.delete
      @bl3.delete
      @cz1.delete
      @cz2.delete
      @cz3.delete
      # @ca1.delete
      # @ca2.delete
      # @ca3.delete
    end

    def destroy_pastry_prices
      @cr1.delete
    end

  end
end