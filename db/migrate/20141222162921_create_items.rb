class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.string :category
      t.integer :units_per_item
      t.float :weight
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
