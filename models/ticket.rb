module Ichigo
  module Models
    class Ticket < Sequel::Model
      def show
        channel = bot.server( server_id ).channels.find { |ch| ch.id == CONFIG["admin_channel_id"] }

        channel.send_embed do |embed|
          embed.title = "Ticket Nº ##{id}"
          embed.color = 0x7EC0EE
          embed.description = "Use \"go!ticket ##{id} create\" to create a ticket."
          embed.add_field name: "User", value: user, inline: true
          embed.add_field name: "Status", value: "Open" if status == 1
          embed.add_field name: "Time opened", value: created_at.strftime( "%d/%m/%Y %H:%M" ), inline:true
          embed.add_field name: "Time finished", value: updated_at.strftime( "%d/%m/%Y %H:%M" ), inline: true unless updated_at.nil?
          embed.add_field name: "Content", value: content
        end
      end

      def create
        self.update(status: 0)
      end
    end
  end
end