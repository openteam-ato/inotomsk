class ChangeColumnTypInPlacemarks < ActiveRecord::Migration
  def change
    change_column :placemarks, :title, :text
  end
end
