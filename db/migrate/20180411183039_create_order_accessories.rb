class CreateOrderAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :order_accessories, id: false do |t|
      t.references :order, foreign_key: true
      t.references :accessory, foreign_key: true
      t.integer :quantity
    end
  end
end
