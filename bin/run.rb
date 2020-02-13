require_relative '../config/environment.rb'


# test_weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
 



def location_coordinates()
    puts "enter your location"
    results = gets.chomp()
    location = Geocoder.search(results)
    first_location = location.first.coordinates
    first_location.split(",")
    puts first_location
end

location_coordinates()

# results = Geocoder.search("Paris")
# puts results.first.coordinates
