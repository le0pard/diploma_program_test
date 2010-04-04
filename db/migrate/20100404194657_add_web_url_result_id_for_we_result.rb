class AddWebUrlResultIdForWeResult < ActiveRecord::Migration
  def self.up
    add_column :web_results, :web_url_result_id, :integer
  end

  def self.down
    remove_column :web_results, :web_url_result_id
  end
end
