class UserSession
    attr_accessor :current_user, :commands

    def initialize
        welcome
        start
    end

    def welcome
        puts "#" * 25
        puts "Welcome to Trip Finder!"
        puts "#" * 25
    end
    
    def login
        puts "Please Login"
        puts "\nEnter username"
        username = gets.chomp
        puts "\nEnter password"
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

    def set_user_temp
        if @current_user.highest_temp == nil || @current_user.lowest_temp == nil
            puts "\nYou're temperature preferences aren't set."
            puts "Would you like to add them? Y/n"
            if gets.chomp == 'Y'
                self.prompt_user_to_set_temp
            end
        else
            puts "\nYour maximum and lowest set temperatures are #{@current_user.highest_temp}F and #{@current_user.lowest_temp}F"
            puts "Would you like to change it? Y/n"
            if gets.chomp == 'Y'
                self.prompt_user_to_set_temp
            end
        end
    end
    
    def prompt_user_to_set_temp
        puts "What temperature is too hot for you?"
        max = gets.chomp
        puts "What temperature is too cold for you?"
        min = gets.chomp
        if validate_temps(max, min)
            @current_user.set_temps(max, min)
        end
    end

    def validate_temps(max, min)
        if max < min
            puts "Your max temperature can't be lower than your min."
            set_temp_pref
        else
            true
        end
    end
    
    def find_user(username)
        User.find_by username: username
    end

    def set_user(username, password)
        @current_user = User.find_by username: username, password: password
        puts "You're logged in as #{@current_user.username}"
    end

    def generate_new_location
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
            location = user_location.location
            puts "=" * 25
            puts "#{location.name}, #{location.country}"
            weather_data = location.weather_api(location.latitude, location.longitude)
            location.weather(weather_data)
        end
    end

    def whoami
        puts "\nYou're logged in as #{current_user.username}"
    end

    def print_commands
        if !@current_user
            @commands = [
                "'help' - Displays available commands",
                "'login' - Prompts a user to login",
                "'signup' - Allows a user to create an account",
                "'exit' - Closes the program"
            ]
        else
            @commands = [
                "'help' - Displays available commands",
                "'temp' - Allows the user to temp their recommended temperature",
                "'search' - Searches for a new Travel Location",
                "'locations' - Returns a list of the users saved locations",
                "'logout' - Logs out a user",
                "'whoami' - Tells the users whos currently logged in",
                "'exit' - Closes the program"
            ]     
        end
        puts @commands
    end

    def start
        while self
            while @current_user
                puts "\nWhat would like to do?"
                puts "Type 'help' for a list of commands"
    
                case gets.chomp
                when "help"
                    self.print_commands
                when "temp"
                    self.set_user_temp
                when "search"
                    self.generate_new_location
                when "locations"
                    self.user_locations_list
                when "logout"
                    self.logout
                when "whoami"
                    self.whoami
                when "exit"
                    abort("Ending program... goodbye!")
                end
            end
            
            while !@current_user
                puts "\nPlease 'login' or 'signup' to countinue"
            
                case gets.chomp
                when "login"
                    self.login
                when "signup"
                    self.create_user
                when "help"
                    self.print_commands
                when "exit"
                    abort("Ending program... goodbye!")
                end    
            end
        end
    end

end