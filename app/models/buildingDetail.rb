class BuildingDetail < ApplicationRecord
    belongs_to :building, optional: true
    has_one :building
    has_one :customer
end
