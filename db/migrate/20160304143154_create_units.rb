class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :units
      t.string :serial
      t.string :model_type
      t.integer :ship_id
      t.datetime :ship_date
      t.string :customer_no
      t.string :order_no
    end
    add_index :units, :serial
    add_index :units, :model_type
    add_index :units, :ship_id
    add_index :units, :ship_date
    add_index :units, :customer_no
    add_index :units, :order_no
  end
end
