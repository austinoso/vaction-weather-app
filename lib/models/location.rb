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
        puts response_hash
    end
    
    def current_temp()
        #last two float numbers are the coordinates which need to be plugged in
        weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
        response_hash = JSON.parse(weather_data)
        puts "Current temp is: #{response_hash["currently"]["temperature"] + 32.round}F"
    end
    
    def current_humidity()
        #last two float numbers are the coordinates which need to be plugged in
        weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
        response_hash = JSON.parse(weather_data)
        puts "Current humidity is: #{response_hash["currently"]["humidity"] *100}%"
    end
    
    
end