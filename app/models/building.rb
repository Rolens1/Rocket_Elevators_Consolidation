class Building < ApplicationRecord
    belongs_to :customer, optional: true
    belongs_to :adress, optional: true
    has_many :batteries
    has_one :buildingDetail
    has_one :adress
end
