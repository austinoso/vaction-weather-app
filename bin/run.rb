require_relative '../config/environment.rb'

puts "testing run file"

weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
 
pp = JSON.parse(weather_data)

puts pp

