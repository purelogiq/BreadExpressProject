class CreateItemPrices < ActiveRecord::Migration
  def change
    create_table :item_prices do |t|
      t.integer :item_id
      t.float :price
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
