class StaticPagesController < ApplicationController
  before_action :already_logged_in, only: [:home]
  
  def home
  end

  def help
  end
  
  def about 
  end 
  
  def contact
  end
  
  private
    
    # Determines whether already logged in.
    def already_logged_in
      if logged_in?
        redirect_to dashboard_url
      end
    end
  
end
