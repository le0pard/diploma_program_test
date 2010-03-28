class WebTestController < ApplicationController
  
  def index
    @web_tests = WebTest.paginate :per_page => 20, :page => params[:page], :order => 'name'
  end
  
  def new
    @web_test = WebTest.new
  end
  
  def create
    @web_test = WebTest.new(params[:web_test])
    if @web_test.save
      flash[:notice] = "Successfully added"
      redirect_to :action => :edit, :id => @web_test.id
    else
      render :action => :new
    end
  end
  
  def show
    @web_test = WebTest.find(params[:id])
  end

  def edit
    @web_test = WebTest.find(params[:id])
  end
  
  def update
    @web_test = WebTest.find(params[:id])
    if @web_test.update_attributes(params[:web_test])
      flash[:notice] = "Successfully updated"
      redirect_to :action => :edit, :id => @web_test.id
    else
      render :action => :edit, :id => params[:id]
    end
  end

  def destroy
    @web_test = WebTest.find(params[:id])
    @web_test.destroy if @web_test
    redirect_to :action => :index
  end
  
end
