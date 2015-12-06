class Link < ActiveRecord::Base
    belongs_to :publisher
    has_many :generatedlinks, dependent: :destroy
    validates :url,  presence: true
    validates :cpm,  presence: true
    validates :category, inclusion: { in: %w(Health Fitness Hipster Science Funny Happiness),
        message: " was not a valid category" }
end
