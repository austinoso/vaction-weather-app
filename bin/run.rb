require_relative '../config/environment.rb'


# test_weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
 


def current_temp()
    puts "Enter city that you would like to see the temperature of."
    results = gets.chomp
    weather_data = RestClient.get("https://api.darksky.net/forecast/773a54e5e33804db37622417cee9961e/42.3601,-71.0589")
    response_hash = JSON.parse(weather_data)
    puts "Current temp is: #{response_hash["currently"]["temperature"] + 32.round}F"
end

current_temp()