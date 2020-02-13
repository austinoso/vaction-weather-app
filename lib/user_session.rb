class UserSession
    attr_accessor :current_user, :commands

    def initialize
        @commands = [
            "'help' - Displays available commands",
            "'temp' - Allows the user to temp their recommended temperature",
            "'search' - Searches for a new Travel Location",
            "'locations' - Returns a list of the users saved locations"
        ]
        welcome
    end

    def welcome
        puts "#" * 25
        puts "Welcome to Trip Finder!"
        puts "#" * 25
        @c
    end
    
    def login
        puts "Please Login"
        puts "Enter username"
        username = gets.chomp
        puts "Enter password"
        password = gets.chomp
        if validate(username,password)
            set_user(username, password)
        else
            puts "\nWrong username and password combination."
            puts "Please try again or create an account."
        end
    end

    def logout
        puts "\nUser #{@current_user.username} has logged out."
        @current_user = nil
    end

    def validate(username, password)
        User.find_by username: username, password: password
    end

    def create_user
        puts "What should be call you?"
        username = gets.chomp
        while find_user(username)
            puts "\nUser already exists with that name."
            puts "Please choose another"
            username = gets.chomp
        end
        puts "Please enter a password."
        password = gets.chomp
        @current_user = User.create(username: username, password: password)
    end

    def temp
        if !self.current_user.temp_pref
            self.ask_temp_pref
        else
            puts "\nYour prefered temperature is #{@current_user.temp_pref}"
            puts "Would you like to change it? Y/n"
            if gets.chomp == 'Y'
                self.ask_temp_pref
            end
        end
    end
    
    def ask_temp_pref
        puts "\nWhat temperature do you prefer? 'cold' or 'hot'"
        @current_user.set_temp_pref(gets.chomp)
        puts "Current temperature set to #{@current_user.temp_pref}"
    end
    
    def find_user(username)
        User.find_by username: username
    end

    def set_user(username, password)
        @current_user = User.find_by username: username, password: password
        puts "You're logged in as #{@current_user.username}"
    end

    def new_location
        location = Location.search
        puts "Welcome to beauitful #{location.name}, #{location.country}"
        puts 'Would you like to save this location to your "Travel List"? Y/n'

        if gets.chomp == 'Y'
            puts "Location saved!"
            UserLocation.create(user: @current_user, location: location)
        end
    end

    def user_locations_list
        UserLocation.all.where(user: @current_user).map do |user_location|
            puts "=" * 20
            puts "#{user_location.location.name}, #{user_location.location.country}"
        end
    end

    def whoami
        puts "\nYou're logged in as #{current_user.username}"
    end

end