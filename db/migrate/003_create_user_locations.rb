class CreateUserLocations < ActiveRecord::Migration[5.2]
    def change
        create_table :user_locations do |t|
            t.string :name
            t.string :country
            t.integer :user_id
            t.integer :location_id
        end
    end
end