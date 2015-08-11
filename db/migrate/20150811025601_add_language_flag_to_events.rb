class AddLanguageFlagToEvents < ActiveRecord::Migration
  def change
    add_column :events, :language, :string

    Event.update_all(:language => "ru")
  end
end
