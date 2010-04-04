class WebResult < ActiveRecord::Base

  # === List of columns ===
  #   id                : integer 
  #   web_task_id       : integer 
  #   count             : integer 
  #   cpu_avr1          : string 
  #   cpu_avr5          : string 
  #   cpu_avr15         : string 
  #   mem_total         : string 
  #   mem_used          : string 
  #   mem_free          : string 
  #   swap_total        : string 
  #   swap_used         : string 
  #   swap_free         : string 
  #   process_all       : integer 
  #   process_running   : integer 
  #   server_load_time  : decimal 
  #   web_load_time     : decimal 
  #   html_data         : text 
  #   time_of_test      : datetime 
  #   created_at        : datetime 
  #   updated_at        : datetime 
  #   web_url_result_id : integer 
  # =======================

  
  belongs_to :web_task
  belongs_to :web_url_result
end
