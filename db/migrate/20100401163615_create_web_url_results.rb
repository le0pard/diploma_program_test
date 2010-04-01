class CreateWebUrlResults < ActiveRecord::Migration
  def self.up
    create_table :web_url_results do |t|
      t.integer :web_task_id
      t.integer :count, :default => 0
      t.decimal :web_load_time
      t.text :base_uri
      t.text :content_type
      t.text :content_data
      t.timestamps
    end
  end

  def self.down
    drop_table :web_url_results
  end
end
