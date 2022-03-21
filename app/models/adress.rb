class Adress < ApplicationRecord
    has_many :customers
    belongs_to :customer, optional: true
    belongs_to :building, optional: true
end
