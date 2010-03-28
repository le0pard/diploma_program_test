class WebTaskController < ApplicationController
  
  def index
    @pages = Page.paginate :per_page => 20, :page => params[:page], :order => 'name'
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = I18n.t("flashes.page.add")
      redirect_to :action => :edit, :id => @page.id
    else
      render :action => :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = I18n.t("flashes.page.edit")
      redirect_to :action => :edit, :id => @page.id
    else
      render :action => :edit, :id => params[:id]
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy if @page
    redirect_to :action => :index
  end
  
  def sort
    @pages = Page.menu.all
  end
  
  def update_sort
    if params[:sort_box] && params[:sort_box].is_a?(Array)
      i = 1
      params[:sort_box].each do |id|
        if page = Page.find(id)
          page.update_attribute(:sort, i)
          i += 1
        end
      end
    end
    render :nothing => true
  end
  
end
