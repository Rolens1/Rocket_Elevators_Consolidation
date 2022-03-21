class Customer < ApplicationRecord
    belongs_to :user, optional: true
    has_many :adresses
    has_many :buildings
end
