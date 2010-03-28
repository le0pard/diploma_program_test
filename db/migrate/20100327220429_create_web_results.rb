class CreateWebResults < ActiveRecord::Migration
  def self.up
    create_table :web_results do |t|
      t.integer :web_task_id
      t.integer :count, :default => 0
      
      t.string :cpu_avr1
      t.string :cpu_avr5
      t.string :cpu_avr15
      
      t.string :mem_total
      t.string :mem_used
      t.string :mem_free
      
      t.string :swap_total
      t.string :swap_used
      t.string :swap_free
      
      t.integer :process_all
      t.integer :process_running
      
      t.decimal :server_load_time
      t.decimal :web_load_time
      
      t.text :html_data
      
      t.datetime :time_of_test
      t.timestamps
    end
  end

  def self.down
    drop_table :web_results
  end
end
