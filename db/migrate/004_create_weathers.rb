class CreateWeathers < ActiveRecord::Migration[5.2]
    def change 
        create_table :weathers do |t|
            t.string :location
            t.float :temperature 
            t.float :humidity
            t.integer :location_id
        end
    end
end