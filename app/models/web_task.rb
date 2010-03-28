class WebTask < ActiveRecord::Base

  # === List of columns ===
  #   id           : integer 
  #   web_test_id  : integer 
  #   url          : string 
  #   http_method  : integer 
  #   http_params  : text 
  #   count_repeat : integer 
  #   sort         : integer 
  #   created_at   : datetime 
  #   updated_at   : datetime 
  #   name         : string 
  # =======================

  
  belongs_to :web_test
  has_many :web_results
  
  default_scope :order => 'sort'
end
