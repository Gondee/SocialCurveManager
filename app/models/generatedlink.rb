class Generatedlink < ActiveRecord::Base
    belongs_to :user, dependent: :destroy
    belongs_to :link, dependent: :destroy
    has_many :statistics, dependent: :destroy
    
end

