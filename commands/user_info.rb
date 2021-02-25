module Ichigo
  module Commands
        module UserInfo
            extend Discordrb::Commands::CommandContainer

    command :userinfo, description: "Ichigo User Info - show information about a member." do |event|
    event.channel.send_embed do |embed|
      user = event.user
      user = event.message.mentions.first.on(event.server) unless event.message.mentions.empty?
  
      embed.color = 0x120A8F
      embed.timestamp = Time.now
      embed.thumbnail = { url: user.avatar_url }
      embed.footer    = { text: "Date taken #{Time.now.strftime( "%d/%m/%Y" )} - #{event.server.name}." }
      embed.add_field name: "Name", value: user.display_name, inline: true
      embed.add_field name: "Member since", value: user.joined_at.strftime("%d/%m/%Y"), inline: true
  end
  end
end
end
end