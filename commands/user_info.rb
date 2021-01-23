module Ichigobot
  module Commands
    module UserInfo
      extend Discordrb::Commands::CommandContainer

      def self.user_info(event, user)
        event.channel.send_embed do |embed|
          embed.thumbnail = { url: user.avatar_url }
          embed.footer    = { text: "Time taken #{Time.now.strftime( "%d/%m/%Y" )} - #{event.server.name}." }
          embed.add_field name: "Name", value: user.display_name, inline: true
          embed.add_field name: "Member since", value: user.joined_at.strftime("%d/%m/%Y"), inline: true
        end
      end

      command :userinfo, description: "Ichigo User Info - show information about a member." do |event|
        user = event.user
        user = event.message.mentions.first.on(event.server) unless event.message.mentions.empty?
        user_info event, user
      end
    end
  end
end
