require "http"
require "json"

puts "Where are you located?"
location = gets.chomp

puts "Checking weather at #{location}..."

# find latitude and longitude from Google Maps API
gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_key}"

raw_gmaps_data = HTTP.get(gmaps_url)

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

# pp results_array.at(0)

geometry_hash = results_array.at(0).fetch("geometry")
latitude = geometry_hash.fetch("location").fetch("lat")
longitude = geometry_hash.fetch("location").fetch("lng")
# pp latitude

puts "Your coordinates are #{latitude}, #{longitude}."

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

raw_pirate_weather_data = HTTP.get(pirate_weather_url)

parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)

# pp parsed_pirate_weather_data

current_temp = parsed_pirate_weather_data.fetch("currently").fetch("temperature")

puts "It is currently #{current_temp}°F."
