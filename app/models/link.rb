class Link < ActiveRecord::Base
    belongs_to publisher, dependent: :destroy
    has_many generatedlinks, dependent: :destroy
end
