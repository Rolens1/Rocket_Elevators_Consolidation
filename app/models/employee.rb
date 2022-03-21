class Employee < ApplicationRecord
    # establish_connection MYSQL_DB
    has_one :user
    belongs_to :user, optional: true
end
