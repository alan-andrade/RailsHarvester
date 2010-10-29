class QueriesController < ApplicationController
  def new    
  end
  
  def create
    @query = params[:query]    
    @records = Record.find(:all,:conditions  =>  ["description LIKE ? OR title LIKE ?", "%#{@query}%", "%#{@query}%"])
    render  :action =>  :show
  end
  
  def show    
  end
  
end
