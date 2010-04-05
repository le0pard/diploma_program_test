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
  
  def self.comparison(web_task)
    WebTask.all(:joins => :web_test, :conditions => ["web_tasks.count_repeat = ? AND web_tasks.id != ? AND web_tests.launched = ? AND resulted_at IS NOT NULL", web_task.count_repeat, web_task.id, true])
  end
  
  def self.done_all
    WebTask.all(:joins => :web_test, :conditions => ["web_tests.launched = ? AND resulted_at IS NOT NULL", true])
  end
  
  def http_method_name
    meth = ['GET', 'POST']
    meth[http_method]
  end
  
  def method_get?
    self.http_method == 0
  end
  
  def method_post?
    self.http_method == 1
  end
  
end
