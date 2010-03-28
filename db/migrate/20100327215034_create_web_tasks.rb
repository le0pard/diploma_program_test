class CreateWebTasks < ActiveRecord::Migration
  def self.up
    create_table :web_tasks do |t|
      t.integer :web_test_id
      t.string :url
      t.integer :http_method, :default => 0 # GET
      t.text :http_params, :default => ""
      t.integer :count_repeat, :default => 0
      t.integer :sort, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :web_tasks
  end
end
