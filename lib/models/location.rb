class Location < ActiveRecord::Base
    has_many :user_locations
    has_many :users, through: :user_locations

    def self.search
        country = ISO3166::Country.new(ISO3166::Country.all.sample.alpha2)
        city = country.cities[country.cities.keys.sample]
        location = Location.create(name: city.name, country: country.name, latitude: city.latitude, longitude: city.longitude)
    end
end