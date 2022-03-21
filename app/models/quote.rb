class Quote < ApplicationRecord
    # establish_connection MYSQL_DB
    self.table_name = "quotes"
end
