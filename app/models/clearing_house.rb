class ClearingHouse < ActiveRecord::Base
    belongs_to :publisher
    belongs_to :users
end
