class User < ActiveRecord::Base
    has_many :user_locations
    has_many :locations, through :user_locations
end