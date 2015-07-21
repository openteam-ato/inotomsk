class ChangeSlugTypeInPlacemarks < ActiveRecord::Migration
  def change
    change_column :placemarks, :slug, :text
  end
end
