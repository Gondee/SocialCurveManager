class Generatedlink < ActiveRecord::Base
    belongs_to :user
    belongs_to :link
    has_many :statistics, dependent: :destroy
    
end

