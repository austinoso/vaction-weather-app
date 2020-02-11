class CreateWeathers < ActiveRecord::Migration
    def change 
        create table :weathers do |t|
            t.string :location
            t.float :temperature 
            t.float:humidity
            t.integer :location_id
        end
    end
end