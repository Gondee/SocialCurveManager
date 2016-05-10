class ClearingHouse < ActiveRecord::Base
    belongs_to :publisher
    belongs_to :users
    
    def getClearedPublishers
        return ClearingHouse.where("user_id =?", current_user_id)
    end
    
    #Assumes call has already checked what publishers are Ok
    def getContent(pub_id)
        #get the current users permissions
        #@permissions = ClearingHouse.where("user_id =?", current_user_id)
        
        currentLinks = Generatedlink.where("user_id=?",current_user_id).pluck(:link_id)
        return Link.where("publisher_id =?",pub_id).not(currentLinks)
        
    end
    
    
end
