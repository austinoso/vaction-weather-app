class AddUserPrefs < ActiveRecord::Migration[5.2]
    add_column :users, :lowest_temp, :string
    add_column :users, :highest_temp, :string
    add_column :users, :max_humidity, :integer
end