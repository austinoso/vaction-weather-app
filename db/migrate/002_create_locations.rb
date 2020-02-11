class CreateLocations < ActiveRecord::Migration
    def change
        create_table :locations do |t|
            t.string :name
            t.integer :weather_id
        end
    end
end