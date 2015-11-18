class Publisher < ActiveRecord::Base
    has_many :links, dependent: :destroy
    has_many :clearing_houses, dependent: :destroy
    belongs_to :user, dependent: :destroy
end
