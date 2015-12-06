class Generatedlink < ActiveRecord::Base
    belongs_to :user
    belongs_to :link
    has_many :statistics, dependent: :destroy
    
    def user_email_title_clicks
       @user = User.find(user_id)
       @user.email
       @title = Link.find(link_id)
      
       obj = @user.email.to_s + " - " +  @title.title.to_s + " - " + paidclicks.to_s + " Clicks"
    end
end

