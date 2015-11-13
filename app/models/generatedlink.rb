class Generatedlink < ActiveRecord::Base
    belongs_to :user, dependent: :destroy
    belongs_to :link, dependent: :destroy
    
end

