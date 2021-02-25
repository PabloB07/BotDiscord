module Ichigo
  module Models
    class Ban
      plugin :enum
      enum   :event, [:ban, :kick, :unban]

      def template(msg)
        msg << "**Incident nº ##{id}**"
        msg << "**Member #{event}**."
        msg << "**User:** #{user}."
        msg << "**Moderator:** #{moderator}."
        msg << "**Reason:** #{reason}.\n"
      end

      def show
        msg = []
        template msg
      end

      def transparency
        msg = []
        msg = template msg

        channel = bot.server(server_id).channels.find { |ch| ch.id == CONFIG["transparency_channel_id"] }
        channel.send_message msg.join "\n" if channel
      end
    end
  end
end