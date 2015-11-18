class ClearingHouse < ActiveRecord::Base
    belongs_to :publisher, dependent: :destroy
    belongs_to :users, dependent: :destroy
end
