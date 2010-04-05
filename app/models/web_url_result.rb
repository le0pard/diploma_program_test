class WebUrlResult < ActiveRecord::Base

  # === List of columns ===
  #   id            : integer 
  #   web_task_id   : integer 
  #   count         : integer 
  #   web_load_time : decimal 
  #   base_uri      : text 
  #   content_type  : text 
  #   content_data  : text 
  #   created_at    : datetime 
  #   updated_at    : datetime 
  # =======================


  belongs_to :web_task
  has_one :web_result
  
  default_scope :order => 'created_at'
end
