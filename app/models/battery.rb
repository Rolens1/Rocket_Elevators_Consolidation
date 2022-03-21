class Battery < ApplicationRecord
    belongs_to :building, optional: true
    has_many :columns
end
