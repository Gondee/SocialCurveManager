class ApplicationController < ActionController::Base
  before_action :logged_in_user, only: []
  def index
    
  end
  def about
    
  end
  def contact
    
  end
  def signin
    
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include SessionsHelper
  include LinksHelper
  include StatsupdatersHelper
  
end
