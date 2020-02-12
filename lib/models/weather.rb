class Weather < ActiveRecord::Base
    belongs_to :location
end

# Dark Sky APO key 773a54e5e33804db37622417cee9961e