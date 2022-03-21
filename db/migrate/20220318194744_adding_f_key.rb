class AddingFKey < ActiveRecord::Migration[5.2]
  def change
    add_reference :buildingdetails, :buildings, foreign_key: true
  end
end
