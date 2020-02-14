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

    def saved_locations
        UserLocation.all.where(user: self).map { |user_location| user_location.location} 
    end

    def find_user_location_by_location(location)
        UserLocation.find_by location: location, user: self
    end

    def remove_user_location_by_location(location)
        self.find_user_location_by_location(location).delete
    end

    def locations?
        self.saved_locations.empty?
    end

    def get_temps
        {
            :max_temp => self.highest_temp.to_f,
            :low_temp => self.lowest_temp.to_f
        }
    end

    def temps?
        if self.lowest_temp && self.highest_temp
            return true
        end
        false
    end
end