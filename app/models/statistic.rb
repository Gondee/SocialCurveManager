class Statistic < ActiveRecord::Base
    belongs_to :generatedlink, dependent: :destroy
end
