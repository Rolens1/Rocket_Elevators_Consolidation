class Elevator < ApplicationRecord
    belongs_to :column, optional: true
    has_one :column
end
