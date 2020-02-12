class User < ActiveRecord::Base
    has_many :user_locations
    has_many :locations, through: :user_locations

    def set_max_humidity(humidity_percent)
        if humidity_percent > 100
            puts "Can't set higher than 100%"
            puts "Setting your max humidity to 100%"
            self.max_humidity = 100
        elsif humidity_percent < 40
            puts "Can't set lower than 40%"
            puts "Setting your max humidity to 40%"
            self.max_humidity = 40
        else
            self.max_humidity = humidity_percent
        end
    end
end