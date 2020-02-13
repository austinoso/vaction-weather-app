class UserSession
    attr_accessor :current_user, :commands

    def initialize
        @commands = [
            "'help' - Displays available commands",
            "'temp' - Allows the user to temp their recommended temperature",
            "'search' - Searches for a new Travel Location"
        ]
        welcome
        login
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
        set_user(username, password)
    end

    def temp
        if !self.current_user.temp_pref
            self.ask_temp_pref
        else
            puts "Your prefered temperature is #{@current_user.temp_pref}"
            puts "Would you like to change it? Y/n"
            if gets.chomp == 'Y'
                self.ask_temp_pref
            end
        end
    end
    
    def ask_temp_pref
        puts "What temperature do you prefer? 'cold' or 'hot'"
        @current_user.set_temp_pref(gets.chomp)
        puts "Current temperature set to #{@current_user.temp_pref}"
    end
    
    def find_user(username, password)
        User.find_by username: username, password: password
    end

    def set_user(username, password)
        if !find_user(username, password)
            puts "No user found, would you like to create an account?"
            puts "Y/n"
            response = gets.chomp
            if response == "Y"
                @current_user = User.create(username: username, password: password)
            else
                puts "Oh.. I see..."
            end
        else
            @current_user = find_user(username, password)
        end
    end

    def new_location
        location = Location.search
        puts "Welcome to beauitful #{location.name}, #{location.country}"
        puts 'Would you like to save this location to your "Travel List"? Y/n'

        if gets.chomp == 'Y'
            puts "Location saved!"
            #@current_user.locations = location
        end
    end

end