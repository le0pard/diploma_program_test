class StatisticComparisonController < ApplicationController
  
  def index
    @main_selector = WebTask.done_all
    if params[:web_task_id1] && params[:web_task_id2]
      @web_task1 = WebTask.find(params[:web_task_id1]) rescue nil
      @web_task2 = WebTask.find(params[:web_task_id2]) rescue nil
      return (redirect_to root_path) if @web_task1.nil? || @web_task2.nil?
      @compare_methods = compare_methods
      @compare_method_selected = params[:compare_method] ? params[:compare_method] : compare_methods[0]
      
      @graph, @graph_div = open_flash_chart_object_and_div_name(700, 400, compare_tasks_data_path(:web_task_id1 => @web_task1.id, :web_task_id2 => @web_task2.id, :compare_method => @compare_method_selected))
    elsif params[:web_task_id1]
      @web_task1 = WebTask.find(params[:web_task_id1]) rescue nil
      return (redirect_to root_path) if @web_task1.nil?
    end
    @alternatives_selector = WebTask.comparison(@web_task1) if @web_task1
  end
  
  def data
    if params[:web_task_id1] && params[:web_task_id2] && params[:compare_method]
      @web_task1 = WebTask.find(params[:web_task_id1]) rescue nil
      @web_task2 = WebTask.find(params[:web_task_id2]) rescue nil
      return (redirect_to root_path) if @web_task1.nil? || @web_task2.nil?
      
      #cpu
      case params[:compare_method]
        when "web"
          title = Title.new("Web load")
    
          data1 = []
          data2 = []
          max_value = 0
        
          data_x = []
  
          @web_task1.web_results.each do |web_result|
            all_load_time = web_result.web_url_result ? web_result.web_url_result.web_load_time.to_f * 1000.0 : web_result.web_load_time.to_f * 1000.0
            data1 << all_load_time
            
            max_value = all_load_time if max_value < all_load_time
            data_x << web_result.time_of_test
          end
          @web_task2.web_results.each do |web_result|
            all_load_time = web_result.web_url_result ? web_result.web_url_result.web_load_time.to_f * 1000.0 : web_result.web_load_time.to_f * 1000.0
            data2 << all_load_time
            
            max_value = all_load_time if max_value < all_load_time
          end
          
          line = Line.new
          line.text = "Web load time (#{@web_task1.name})"
          line.width = 2
          line.colour = '#5E4725'
          line.dot_size = 10
          line.values = data1
          
          line2 = Line.new
          line2.text = "Web load time (#{@web_task2.name})"
          line2.width = 2
          line2.colour = '#DB1750'
          line2.dot_size = 5
          line2.values = data2
          
          y_legend = YLegend.new("Time (miliseconds)")
          y_legend.set_style('{font-size: 20px; color: #770077}')
        when "cpu1", "cpu5", "cpu15"
          title = Title.new("CPU")
    
          data1 = []
          data2 = []
          max_value = 0
        
          data_x = []
  
          @web_task1.web_results.each do |web_result|
            if params[:compare_method] == "cpu1"
              data1 << web_result.cpu_avr1.to_f
              max_value = web_result.cpu_avr1.to_f if max_value < web_result.cpu_avr1.to_f
            elsif params[:compare_method] == "cpu5"
              data1 << web_result.cpu_avr5.to_f
              max_value = web_result.cpu_avr5.to_f if max_value < web_result.cpu_avr5.to_f
            elsif params[:compare_method] == "cpu15"
              data1 << web_result.cpu_avr15.to_f
              max_value = web_result.cpu_avr15.to_f if max_value < web_result.cpu_avr15.to_f
            end  
            data_x << web_result.time_of_test
          end
          @web_task2.web_results.each do |web_result|
            if params[:compare_method] == "cpu1"
              data2 << web_result.cpu_avr1.to_f
              max_value = web_result.cpu_avr1.to_f if max_value < web_result.cpu_avr1.to_f
            elsif params[:compare_method] == "cpu5"
              data2 << web_result.cpu_avr5.to_f
              max_value = web_result.cpu_avr5.to_f if max_value < web_result.cpu_avr5.to_f
            elsif params[:compare_method] == "cpu15"
              data2 << web_result.cpu_avr15.to_f
              max_value = web_result.cpu_avr15.to_f if max_value < web_result.cpu_avr15.to_f
            end
          end
          
          line = Line.new
          line.text = "CPU Avr 1 min (#{@web_task1.name})" if params[:compare_method] == "cpu1"
          line.text = "CPU Avr 5 min (#{@web_task1.name})" if params[:compare_method] == "cpu5"
          line.text = "CPU Avr 15 min (#{@web_task1.name})" if params[:compare_method] == "cpu15"
          line.width = 2
          line.colour = '#5E4725'
          line.dot_size = 10
          line.values = data1
          
          line2 = Line.new
          line2.text = "CPU Avr 1 min (#{@web_task2.name})" if params[:compare_method] == "cpu1"
          line2.text = "CPU Avr 5 min (#{@web_task2.name})" if params[:compare_method] == "cpu5"
          line2.text = "CPU Avr 15 min (#{@web_task2.name})" if params[:compare_method] == "cpu15"
          line2.width = 2
          line2.colour = '#DB1750'
          line2.dot_size = 5
          line2.values = data2
          
          y_legend = YLegend.new("Average")
          y_legend.set_style('{font-size: 20px; color: #770077}')
        when "swap used", "swap free"
          title = Title.new("Swap")
    
          data1 = []
          data2 = []
          max_value = 0
        
          data_x = []
  
          @web_task1.web_results.each do |web_result|
            if params[:compare_method] == "swap used"
              data1 << web_result.swap_used.to_f
              max_value = web_result.swap_used.to_f if max_value < web_result.swap_used.to_f
            elsif params[:compare_method] == "swap free"
              data1 << web_result.swap_free.to_f
              max_value = web_result.swap_free.to_f if max_value < web_result.swap_free.to_f
            end  
            data_x << web_result.time_of_test
          end
          @web_task2.web_results.each do |web_result|
            if params[:compare_method] == "swap used"
              data2 << web_result.swap_used.to_f
              max_value = web_result.swap_used.to_f if max_value < web_result.swap_used.to_f
            elsif params[:compare_method] == "swap free"
              data2 << web_result.swap_free.to_f
              max_value = web_result.swap_free.to_f if max_value < web_result.swap_free.to_f
            end
          end
          
          line = Line.new
          line.text = "Swap used (#{@web_task1.name})" if params[:compare_method] == "swap used"
          line.text = "Swap free (#{@web_task1.name})" if params[:compare_method] == "swap free"
          line.width = 2
          line.colour = '#5E4725'
          line.dot_size = 10
          line.values = data1
          
          line2 = Line.new
          line2.text = "Swap used (#{@web_task2.name})" if params[:compare_method] == "swap used"
          line2.text = "Swap free (#{@web_task2.name})" if params[:compare_method] == "swap free"
          line2.width = 2
          line2.colour = '#DB1750'
          line2.dot_size = 5
          line2.values = data2
          
          y_legend = YLegend.new("Swap")
          y_legend.set_style('{font-size: 20px; color: #770077}')
         when "memory used", "memory free"
          title = Title.new("Memory")
    
          data1 = []
          data2 = []
          max_value = 0
        
          data_x = []
  
          @web_task1.web_results.each do |web_result|
            if params[:compare_method] == "memory used"
              data1 << web_result.mem_used.to_f
              max_value = web_result.mem_used.to_f if max_value < web_result.mem_used.to_f
            elsif params[:compare_method] == "memory free"
              data1 << web_result.mem_free.to_f
              max_value = web_result.mem_free.to_f if max_value < web_result.mem_free.to_f
            end  
            data_x << web_result.time_of_test
          end
          @web_task2.web_results.each do |web_result|
            if params[:compare_method] == "memory used"
              data2 << web_result.mem_used.to_f
              max_value = web_result.mem_used.to_f if max_value < web_result.mem_used.to_f
            elsif params[:compare_method] == "memory free"
              data2 << web_result.mem_free.to_f
              max_value = web_result.mem_free.to_f if max_value < web_result.mem_free.to_f
            end
          end
          
          line = Line.new
          line.text = "Memory used (#{@web_task1.name})" if params[:compare_method] == "memory used"
          line.text = "Memory free (#{@web_task1.name})" if params[:compare_method] == "memory free"
          line.width = 2
          line.colour = '#5E4725'
          line.dot_size = 10
          line.values = data1
          
          line2 = Line.new
          line2.text = "Memory used (#{@web_task2.name})" if params[:compare_method] == "memory used"
          line2.text = "Memory free (#{@web_task2.name})" if params[:compare_method] == "memory free"
          line2.width = 2
          line2.colour = '#DB1750'
          line2.dot_size = 5
          line2.values = data2
          
          y_legend = YLegend.new("Memory")
          y_legend.set_style('{font-size: 20px; color: #770077}')
        when "processes"
          title = Title.new("Processes")
    
          data1 = []
          data2 = []
          max_value = 0
        
          data_x = []
  
          @web_task1.web_results.each do |web_result|
            data1 << web_result.process_running.to_f
            max_value = web_result.process_running.to_f if max_value < web_result.process_running.to_f
 
            data_x << web_result.time_of_test
          end
          @web_task2.web_results.each do |web_result|
            data2 << web_result.process_running.to_f
            max_value = web_result.process_running.to_f if max_value < web_result.process_running.to_f
          end
          
          line = Line.new
          line.text = "Running processes (#{@web_task1.name})"
          line.width = 2
          line.colour = '#5E4725'
          line.dot_size = 10
          line.values = data1
          
          line2 = Line.new
          line2.text = "Running processes (#{@web_task2.name})"
          line2.width = 2
          line2.colour = '#DB1750'
          line2.dot_size = 5
          line2.values = data2
          
          y_legend = YLegend.new("Count")
          y_legend.set_style('{font-size: 20px; color: #770077}')
        else
          #none
      end
        
        y = YAxis.new
        if params[:compare_method] == "processes"
          y.set_range(0,max_value + 1,1)
        else
          y.set_range(0,max_value + 0.2,0.1)
        end
        
        x = XAxis.new
        
        x_labels = XAxisLabels.new

        tmp = []
        data_x.each do |text|
          x_temp = XAxisLabel.new(text.to_s(:statistic), '#CCC', 10, 90)
          tmp << x_temp
        end
        x_labels.labels = tmp
        
        x.set_labels(x_labels)
    
        x_legend = XLegend.new("Time")
        x_legend.set_style('{font-size: 20px; color: #778877}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
    
        render :text => chart.to_s, :layout => false
    else
      redirect_to root_path
    end
  end
  
  
  private
  
  def compare_methods
    ['web', 'cpu1', 'cpu5', 'cpu15', 'memory used', 'memory free', 'swap used', 'swap free', 'processes']
  end
  
end
