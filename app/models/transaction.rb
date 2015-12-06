class Transaction < ActiveRecord::Base
    has_many :paymentgroups, dependent: :destroy
    
    def information
        @user = User.find(user_id)
        name = @user.first.to_s + " " + @user.last.to_s + " " + note.to_s
    end
    
end
