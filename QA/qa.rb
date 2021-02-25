=begin
module Ichigo
    module Qa
    extend Discordrb::Commands::CommandContainer
    command :qa, help_available: true do |event|
        file = File.open('answers.txt', 'a+')
        file.readlines.send_embed do |f|
            f.title = "".inline
        end        
    end
end
=end