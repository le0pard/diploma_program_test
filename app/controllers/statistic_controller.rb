class StatisticController < ApplicationController
  
  def index
    @cpu_graph = open_flash_chart_object(1000, 400, web_test_statistic_cpu_data_path(:web_test_id => params[:web_test_id], :format => :js))
    @memory_graph = open_flash_chart_object(1000, 400, web_test_statistic_memory_data_path(:web_test_id => params[:web_test_id], :format => :js))
    @swap_graph = open_flash_chart_object(1000, 400, web_test_statistic_swap_data_path(:web_test_id => params[:web_test_id], :format => :js))
    @process_graph = open_flash_chart_object(1000, 400, web_test_statistic_process_data_path(:web_test_id => params[:web_test_id], :format => :js))
    @web_graph = open_flash_chart_object(1000, 400, web_test_statistic_web_data_path(:web_test_id => params[:web_test_id], :format => :js))
  end
  
  
  
  # memory
  def memory_data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("Memory")
    
        data1 = []
        data2 = []
        data3 = []
        max_value = 0
        
        data_x = []

        WebTest.find(params[:web_test_id]).web_tasks.first.web_results.each do |web_result|
          data1 << web_result.mem_used.to_f
          data2 << web_result.mem_free.to_f
          data3 << web_result.mem_total.to_f

          max_value = web_result.mem_total.to_f if max_value < web_result.mem_total.to_f
          
          data_x << web_result.time_of_test
        end
        
        line = Line.new
        line.text = "Memory used"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "Memory free"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
        
        line3 = Line.new
        line3.text = "Memory total"
        line3.width = 2
        line3.colour = '#225900'
        line3.dot_size = 5
        line3.values = data3
    
        y = YAxis.new
        y.set_range(0,max_value + 0.2,0.1)
        
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
    
        y_legend = YLegend.new("Memory")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
        chart.add_element(line3)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
  # cpu
  def cpu_data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("CPU")
    
        data1 = []
        data2 = []
        data3 = []
        max_value = 0
        
        data_x = []

        WebTest.find(params[:web_test_id]).web_tasks.first.web_results.each do |web_result|
          data1 << web_result.cpu_avr1.to_f
          data2 << web_result.cpu_avr5.to_f
          data3 << web_result.cpu_avr15.to_f
          
          max_value = web_result.cpu_avr1.to_f if max_value < web_result.cpu_avr1.to_f
          max_value = web_result.cpu_avr5.to_f if max_value < web_result.cpu_avr5.to_f
          max_value = web_result.cpu_avr15.to_f if max_value < web_result.cpu_avr15.to_f
          
          data_x << web_result.time_of_test
        end
        
        line = Line.new
        line.text = "CPU Avr 1 min"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "CPU Avr 5 min"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
        
        line3 = Line.new
        line3.text = "CPU Avr 15 min"
        line3.width = 2
        line3.colour = '#225900'
        line3.dot_size = 5
        line3.values = data3
    
        y = YAxis.new
        y.set_range(0,max_value + 0.2,0.1)
        
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
    
        y_legend = YLegend.new("Average")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
        chart.add_element(line3)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
  # swap
  def swap_data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("Swap")
    
        data1 = []
        data2 = []
        data3 = []
        max_value = 0
        
        data_x = []

        WebTest.find(params[:web_test_id]).web_tasks.first.web_results.each do |web_result|
          data1 << web_result.swap_used.to_f
          data2 << web_result.swap_free.to_f
          data3 << web_result.swap_total.to_f

          max_value = web_result.swap_total.to_f if max_value < web_result.swap_total.to_f
          
          data_x << web_result.time_of_test
        end
        
        line = Line.new
        line.text = "Swap used"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "Swap free"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
        
        line3 = Line.new
        line3.text = "Swap total"
        line3.width = 2
        line3.colour = '#225900'
        line3.dot_size = 5
        line3.values = data3
    
        y = YAxis.new
        y.set_range(0,max_value + 0.2,0.1)
        
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
    
        y_legend = YLegend.new("Memory")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
        chart.add_element(line3)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
  # process
  def process_data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("Process")
    
        data1 = []
        data2 = []
        data3 = []
        max_value = 0
        
        data_x = []

        WebTest.find(params[:web_test_id]).web_tasks.first.web_results.each do |web_result|
          data1 << web_result.process_running
          data2 << web_result.process_all - web_result.process_running
          data3 << web_result.process_all
          
          max_value = web_result.process_all if max_value < web_result.process_all
          
          data_x << web_result.time_of_test
        end
        
        line = Line.new
        line.text = "Process running"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "Process idle"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
        
        line3 = Line.new
        line3.text = "Total process"
        line3.width = 2
        line3.colour = '#225900'
        line3.dot_size = 5
        line3.values = data3
    
        y = YAxis.new
        y.set_range(0,max_value + 0.2,0.1)
        
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
    
        y_legend = YLegend.new("Count")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
        chart.add_element(line3)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
  
  # web
  def web_data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("Web statistic")
    
        data1 = []
        data2 = []
        data3 = []
        max_value = 0
        
        data_x = []

        WebTest.find(params[:web_test_id]).web_tasks.first.web_results.each do |web_result|
          web_load_time = web_result.web_load_time.to_f * 1000.0
          all_load_time = web_result.web_url_result ? web_result.web_url_result.web_load_time.to_f * 1000.0 : web_result.web_load_time.to_f * 1000.0
          server_busy_time = all_load_time - web_load_time 
          data1 << web_load_time
          data2 << server_busy_time
          data3 << all_load_time

          max_value = all_load_time if max_value < all_load_time
          
          data_x << web_result.time_of_test
        end
        
        line = Line.new
        line.text = "Web load time"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "Server time"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
        
        line3 = Line.new
        line3.text = "All time"
        line3.width = 2
        line3.colour = '#225900'
        line3.dot_size = 5
        line3.values = data3
    
        y = YAxis.new
        y.set_range(0,max_value + 0.2,0.1)
        
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
    
        y_legend = YLegend.new("Time (miliseconds)")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
        chart.add_element(line3)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
end
