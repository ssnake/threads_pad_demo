class CreateStatsTable < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.float :percents
      t.integer :threads_count
      t.datetime :start
      t.datetime :finish
      t.integer :time_delta
    end
    add_index :stats, :percents
    add_index :stats, :threads_count
    add_index :stats, :start
    add_index :stats, :finish
    add_index :stats, :time_delta
  end
end
