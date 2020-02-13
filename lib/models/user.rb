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
    end

    def set_temp_pref(temp)
        if temp == "cold"
            self.temp_pref = temp
        elsif temp == "hot"
            self.temp_pref = temp
        elsif temp == "nil"
            self.temp = nil
        else
            puts "You didn't enter a vaild temperature."
            puts 'Please enter either "cold" or "hot" or "nil" for no preference.'
        end
        self.save
    end

end