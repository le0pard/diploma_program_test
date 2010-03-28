class AddNameToWebTask < ActiveRecord::Migration
  def self.up
    add_column :web_tasks, :name, :string
  end

  def self.down
    remove_column :web_tasks, :name
  end
end
