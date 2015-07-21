class ChangeDatatypeOnPlacemarksFromStringToText < ActiveRecord::Migration
   change_column :placemarks, :title, :text, :limit => nil
   change_column :placemarks, :slug, :text, :limit => nil
end
