class CreateWebTests < ActiveRecord::Migration
  def self.up
    create_table :web_tests do |t|
      t.string :name
      t.boolean :launched, :default => false
      t.datetime :resulted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :web_tests
  end
end
