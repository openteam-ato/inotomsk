class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.string :role
      t.timestamps
    end
    add_index :permissions, [:user_id, :role], :name => 'by_user_and_role'
  end
end
