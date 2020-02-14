class UserSession
    attr_accessor :user, :commands

    def initialize
        welcome
        start
    end

    def welcome
        puts "#" * 25
        puts "Welcome to Trip Finder!"
        puts "#" * 25
    end
    
    #logs in user
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

        #sets the @user
    def set_user(username, password)
        @user = User.find_by username: username, password: password
        puts "You're logged in as #{@user.username}"
    end

    #logs out current user (sets @user to nil)
    def logout
        puts "\nUser #{@user.username} has logged out."
        @user = nil
    end

    #validates a users login
    def validate(username, password)
        User.find_by username: username, password: password
    end

    #creates a new user and saves to db
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
        @user = User.create(username: username, password: password)
    end

    #finds if a user is in the db by username
    def find_user(username)
        User.find_by username: username
    end

    #sets the @user.temps
    def set_user_temp
        if @user.highest_temp == nil || @user.lowest_temp == nil
            puts "\nYou're temperature preferences aren't set."
            puts "Would you like to add them? Y/n"
            if gets.chomp == 'Y'
                self.prompt_user_to_set_temp
            end
        else
            puts "\nYour maximum and lowest set temperatures are #{@user.highest_temp}F and #{@user.lowest_temp}F"
            puts "Would you like to change it? Y/n"
            if gets.chomp == 'Y'
                self.prompt_user_to_set_temp
            end
        end
    end

    #prompts the user to set their temp
    def prompt_user_to_set_temp
        puts "\What temperature is too hot for you?"
        max = gets.chomp
        puts "\nWhat temperature is too cold for you?"
        min = gets.chomp 
        if validate_temps(max, min)
            @user.set_temps(max, min)
        end
    end

    #makes sure the user doesn't set the min temp higher than the max
    def validate_temps(max, min)
        if max < min
            puts "\nYour max temperature can't be lower than your min."
            set_user_temp
        else
            true
        end
    end

    #generates and saves a location
    def generate_new_location
        location = Location.search
        puts "\nWelcome to beauitful #{location.name}, #{location.country}"
        puts 'Would you like to save this location to your "Travel List"? Y/n'
        if gets.chomp == 'Y' 
            puts "Location saved!"
            UserLocation.create(user: @user, location: location)
        end
    end

    #puts a list of users save locations 
    def user_locations_list
        if @user.locations?
            puts "\nNo current locations saved. Run 'search' to start saving locations."
        else
            @user.saved_locations.map do |location|
                puts "=" * 25
                puts "#{location.name}, #{location.country}"
                weather_data = location.weather_api(location.latitude, location.longitude)
                if !@user.get_temps[:max_temp]
                    print_weather(location.weather(weather_data))
                else
                    print_weather_with_color(location.weather(weather_data))
                end
            end
        end
    end

    def print_weather_with_color(weather)
        color = :green
        if weather[:temp] > @user.get_temps[:max_temp] || weather[:temp] < @user.get_temps[:low_temp]
            color = :red
        end
        puts Paint["Current temperature is #{weather[:temp]}F", color]
        puts "Current humidity is #{weather[:humidity]}%"
        puts "#{weather[:status]}"
    end

    def print_weather(weather)
        puts "Current temperature is #{weather[:temp]}F"
        puts "Current humidity is #{weather[:humidity]}"
        puts "#{weather[:status]}"
    end

    def user_delete_locations
        if @user.locations?
            puts "\nNo current locations saved. Run 'search' to start saving locations."
        else
            print_locations_with_number
            remove = @user.saved_locations[get_remove_int - 1]
            puts "Are you sure you want to remove #{remove.name}, #{remove.country} from your travel list? Y/n"
            if gets.chomp == 'Y'
                puts "Removing #{remove.name}, #{remove.country}."
                @user.remove_user_location_by_location(remove)
            else
                puts "Location remains..."
            end
        end
    end

    def print_locations_with_number
        location_index = 0
        @user.saved_locations.map do |location|
            puts "#{location_index += 1}. #{location.name}, #{location.country}"    
        end
    end

    def get_remove_int
        puts "\nType the number of the location you would like to remove from your list"
        remove_int = gets.chomp
        while remove_int.to_i == 0
            puts "\nPlease enter whole numbers only!"
            remove_int = gets.chomp
        end
        remove_int.to_i
    end

    #tells the user who's logged in
    def whoami
        puts "\nYou're logged in as #{user.username}"
    end

    #set useable commands
    def print_commands
        if !@user
            @commands = [
                "'help' - Displays available commands",
                "'login' - Prompts a user to login",
                "'signup' - Allows a user to create an account",
                "'exit' - Closes the program"
            ]
        else
            @commands = [
                "'help' - Displays available commands",
                "'temp' - Allows the user to change/set their recommended temperature",
                "'search' - Searches for a new Travel Location",
                "'locations' - Returns a list of the users saved locations",
                "'remove location' - Allows a user to delete a location",
                "'logout' - Logs out a user",
                "'whoami' - Tells the users whos currently logged in",
                "'delete profile' - Deletes the current user",
                "'change name' - Updates the current users username",
                "'change password' - Updates the current users username",
                "'profile' - Shows profile of current user" ,
                "'exit' - Closes the program"
            ]     
        end
        puts @commands
    end

    ###### Commands ######

    def start
        while self
            while @user
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
                when "remove location"
                    self.user_delete_locations
                when "logout"
                    self.logout
                when "whoami"
                    self.whoami
                when "delete profile"
                    self.can_destroy_profile
                when "change name"
                    self.update_profile_name
                when "change password"
                    self.update_profile_password
                when "profile"
                    self.read_profile 
                when "exit"
                    abort("Ending program... goodbye!")
                end
            end
            
            while !@user
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

    ###### User Profile Methods ######
    
    def can_destroy_profile
        puts "Are you sure you want to delete your profile? Y/n"
        if gets.chomp == "Y" 
            @user.delete
            puts "#{@user.username} has been deleted"
            @user = nil
        else
            puts "Ok deletion averted"
        end
    end

    def update_profile_name
        puts "Would you like to change your current username, #{@user.username}? Y/n"        
        if gets.chomp == "Y"
            puts "Enter your new username"
            new_username = gets.chomp
            while find_user(new_username)
                puts "That name isn't currently available."
                puts "Please enter a different one."
                new_username = gets.chomp
            end
            puts "Username changed from #{@user.username} to #{new_username}"
            @user.username = new_username
            @user.save 
        else
            puts "Ok, we will keep your current name of #{@user.username}"
        end
    end

    def update_profile_password
        puts "Would you like to change the password for #{@user.username}? If yes answer with Y"
        if gets.chomp == "Y"
            puts "Enter your new password"
            @user.password = gets.chomp
            puts "Your new password is #{@user.password}"
            @user.save 
        else
            puts "Ok, we will keep your current password, no changes made."
        end
    end

    def read_profile 
        puts "\nHere is your current profile"
        puts "username: #{@user.username}"
        if @user.highest_temp || @user.lowest_temp
            puts "Your maximum and lowest set temperatures are #{@user.highest_temp}F and #{@user.lowest_temp}F"
        else
            puts "You haven't set your prefered temperatures yet"
        end
    end

end