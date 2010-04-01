class WebTest < ActiveRecord::Base

  # === List of columns ===
  #   id          : integer 
  #   name        : string 
  #   launched    : boolean 
  #   resulted_at : datetime 
  #   created_at  : datetime 
  #   updated_at  : datetime 
  # =======================

  
  has_many :web_tasks
  
  default_scope :order => 'created_at DESC'
  
  
  def activate!
    self.update_attribute(:launched, true)
  end
  
end
