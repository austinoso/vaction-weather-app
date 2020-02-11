class CreateWeathers < ActiveRecord::Migration
    def change 
        create table :weathers do |t|
            t.string :location
            t.integer :temperature 
            t.integer :humidity
            t.integer :location_id
        end
    end
end