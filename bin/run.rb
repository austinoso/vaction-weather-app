require_relative '../config/environment.rb'


# test_weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
 



def weather_api(latitude,longtitude)
    weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/#{latitude},#{longtitude}")
    response_hash = JSON.parse(weather_data)
    puts response_hash
end

def current_temp()
weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
response_hash = JSON.parse(weather_data)
puts "Current temp is: #{response_hash["currently"]["temperature"] + 32.round}F"
end

def current_humidity()
    weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
    response_hash = JSON.parse(weather_data)
    puts "Current humidity is: #{response_hash["currently"]["humidity"] *100}%"
end





# def location_coordinates()
#     puts "enter your location"
#     results = gets.chomp()
#     location = Geocoder.search(results)
#     puts location.first.coordinates
# end

# location_coordinates()

# results = Geocoder.search("Paris")
# puts results.first.coordinates
