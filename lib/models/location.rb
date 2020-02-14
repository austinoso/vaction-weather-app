class Location < ActiveRecord::Base
    has_many :user_locations
    has_many :users, through: :user_locations

    def self.search
        country = ISO3166::Country.all.sample
        city = country.cities[country.cities.keys.sample]
        if city.name == nil || country.name == nil
            Location.search
        else
            Location.create(name: city.name, country: country.name, latitude: city.latitude, longitude: city.longitude)
        end
    end

    def weather_api(latitude,longtitude)
        weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/#{latitude},#{longtitude}")
        response_hash = JSON.parse(weather_data)
    end
    
    def current_temp(weather_data)
        weather_data["currently"]["temperature"].round(2)
    end

    def current_humidity(weather_data)
        weather_data["currently"]["humidity"] * 100
    end

    def current_status(weather_data)
        weather_data["currently"]["summary"]
    end

    def weather(weather_data)
        {
            :temp => current_temp(weather_data).round(2),
            :humidity => current_humidity(weather_data).round(2),
            :status => current_status(weather_data)
        }
    end  
end