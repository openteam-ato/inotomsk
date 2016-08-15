class AddNumberToEventsAndPlacemarks < ActiveRecord::Migration
  def change
    add_column :events, :number, :integer
    add_column :placemarks, :number, :integer
  end
end
