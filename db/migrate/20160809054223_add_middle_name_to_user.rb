class AddMiddleNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :middle_name, :text
  end
end
