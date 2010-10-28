class QueriesController < ApplicationController
  def new    
  end
  
  def create
    @query = params[:query]    
    render  :action =>  :show
  end
  
  def show
    
  end
end
