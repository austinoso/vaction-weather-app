class AddUserPrefs < ActiveRecord::Migration[5.2]
    add_column :users, :temp_pref, :string
    add_column :users, :max_humidity, :integer
end