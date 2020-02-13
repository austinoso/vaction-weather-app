class Location < ActiveRecord::Base
    has_many :user_locations
    has_many :users, through: :user_locations

    def self.search
        country = ISO3166::Country.all.sample
        city = country.cities[country.cities.keys.sample]
        Location.create(name: city.name, country: country.name, latitude: city.latitude, longitude: city.longitude)
    end

    def weather_api(latitude,longtitude)
        weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/#{latitude},#{longtitude}")
        response_hash = JSON.parse(weather_data)
    end
    
    def current_temp(weather_data)
        puts "Current temp is: #{weather_data["currently"]["temperature"].round(2)}F"
    end
    
    def current_humidity(weather_data)
        puts "Current humidity is: #{weather_data["currently"]["humidity"] *100}%"
    end

    def current_status(weather_data)
        puts "#{weather_data["currently"]["summary"]}"
    end
    
    
end