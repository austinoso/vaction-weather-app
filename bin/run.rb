require_relative '../config/environment'

current_session = UserSession.new

while current_session && current_session.current_user
    puts "What would to do?"
    puts "Type 'help' for a list of commands"
    command = gets.chomp

    case command
    when "help"
        puts current_session.commands
    when "temp"
        current_session.temp
    when "search"
        current_session.new_location
    when "locations"
        current_session.user_locations_list
    when "exit"
        current_session = nil
    end
end

#command = gets.chomp
