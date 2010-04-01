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
  has_many :web_url_results
  
  default_scope :order => 'sort'
  
  def http_method_name
    meth = ['GET', 'POST']
    meth[http_method]
  end
end
