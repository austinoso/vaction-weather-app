class CreateLocations < ActiveRecord::Migration[5.2]
    def change
        create_table :locations do |t|
            t.string :name
            t.string :country
            t.float :latitude
            t.float :longitude
        end
    end
end