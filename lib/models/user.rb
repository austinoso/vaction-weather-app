class User < ActiveRecord::Base
    has_many :user_locations
    has_many :locations, through: :user_locations

    def set_max_humidity(humidity_percent)
        if humidity_percent > 100
            puts "Can't set higher than 100%."
            puts "Setting your max humidity to 100%."
            self.max_humidity = 100
        elsif humidity_percent < 60
            puts "Can't set lower than 60%."
            puts "Setting your max humidity to 60%."
            self.max_humidity = 60
        else
            self.max_humidity = humidity_percent
        end
        self.saves
    end

    def set_temps(max, min)
        self.highest_temp = max
        self.lowest_temp = min
        self.save
        puts "\nPreferences saved!"
        puts "\nYour maximum and lowest set temperatures are #{self.highest_temp}F and #{self.lowest_temp}F"
    end
end