class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.integer :customer_id
      t.integer :address_id
      t.float :grand_total
      t.string :payment_receipt

      t.timestamps
    end
  end
end
