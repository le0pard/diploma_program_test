class StatisticController < ApplicationController
  
  def index
    @graph = open_flash_chart_object( 600, 300, web_test_statistic_data_path(:web_test_id => 1, :format => :json))
  end
  
  def data
    respond_to do |response|
      response.json {
        data1 = []
        data2 = []
        year = Time.now.year
    
        31.times do |i|
          x = "#{year}-1-#{i+1}".to_time.to_i
          y = (Math.sin(i+1) * 2.5) + 10
    
          data1 << ScatterValue.new(x,y)
          data2 << (Math.cos(i+1) * 1.9) + 4
        end
    
        dot = HollowDot.new
        dot.size = 3
        dot.halo_size = 2
        dot.tooltip = "#date:d M y#<br>Value: #val#"
    
        line = ScatterLine.new("#DB1750", 3)
        line.values = data1
        line.default_dot_style = dot
    
        x = XAxis.new
        x.set_range("#{year}-1-1".to_time.to_i, "#{year}-1-31".to_time.to_i)
        x.steps = 86400
    
        labels = XAxisLabels.new
        labels.text = "#date: l jS, M Y#"
        labels.steps = 86400
        labels.visible_steps = 2
        labels.rotate = 90
    
        x.labels = labels
    
        y = YAxis.new
        y.set_range(0,15,5)
    
        chart = OpenFlashChart.new
        title = Title.new(data2.size)
    
        chart.title = title
        chart.add_element(line)
        chart.x_axis = x
        chart.y_axis = y
    
        render :text => chart, :layout => false

      }
    end
  end
  
end
