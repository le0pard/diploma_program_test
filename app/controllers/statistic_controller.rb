class StatisticController < ApplicationController
  
  def index
    @graph = open_flash_chart_object(1000, 400, web_test_statistic_data_path(:web_test_id => 1, :format => :js))
  end
  
  def data
    respond_to do |response|
      response.js {
        # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
        title = Title.new("Multiple Lines")
    
        data1 = []
        data2 = []
        max_value = 0
        WebTask.first.web_url_results.each do |web_url_result|
          data1 << web_url_result.web_load_time
          data2 << web_url_result.web_load_time + 2
          if max_value < web_url_result.web_load_time
            max_value = web_url_result.web_load_time
          end
        end
    
        line = Line.new
        line.text = "Line"
        line.width = 2
        line.colour = '#5E4725'
        line.dot_size = 10
        line.values = data1
        
        line2 = Line.new
        line2.text = "Line2"
        line2.width = 2
        line2.colour = '#DB1750'
        line2.dot_size = 5
        line2.values = data2
    
        y = YAxis.new
        y.set_range(0,max_value + 2,0.1)
        
        x = XAxis.new
        x.steps = 5
    
        x_legend = XLegend.new("MY X Legend")
        x_legend.set_style('{font-size: 20px; color: #778877}')
    
        y_legend = YLegend.new("MY Y Legend")
        y_legend.set_style('{font-size: 20px; color: #770077}')
    
        chart =OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.y_axis = y
        chart.x_axis = x

        chart.add_element(line)
        chart.add_element(line2)
    
        render :text => chart.to_s, :layout => false
      }
    end
  end
  
end
