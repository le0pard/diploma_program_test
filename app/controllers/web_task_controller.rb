class WebTaskController < ApplicationController
  
  def new
    @web_task = WebTask.new(:web_test_id => params[:web_test_id])
  end
  
  def create
    @web_task = WebTask.new(params[:web_task])
    if @web_task.save
      flash[:notice] = "Successfully added"
      redirect_to :action => :edit, :id => @web_task.id, :web_test_id => @web_task.web_test_id
    else
      render :action => :new, :web_test_id => @web_task.web_test_id
    end
  end

  def edit
    @web_task = WebTask.find(params[:id])
  end
  
  def update
    @web_task = WebTask.find(params[:id])
    if @web_task.update_attributes(params[:web_task])
      flash[:notice] = "Successfully updated"
      redirect_to :action => :edit, :id => @web_task.id, :web_test_id => @web_task.web_test_id
    else
      render :action => :edit, :id => params[:id], :web_test_id => @web_task.web_test_id
    end
  end

  def destroy
    @web_task = WebTask.find(params[:id])
    @web_task.destroy if @web_task
    redirect_to web_test_path(:id => @web_task.web_test_id)
  end
  
  def sort
    if params[:sort_box] && params[:sort_box].is_a?(Array)
      i = 1
      params[:sort_box].each do |id|
        if web_task = WebTask.find(id)
          web_task.update_attribute(:sort, i)
          i += 1
        end
      end
    end
    render :nothing => true
  end
  
end
