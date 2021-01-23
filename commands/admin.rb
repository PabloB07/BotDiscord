module Ichigobot
  module Commands
    module Admin
      extend Discordrb::Commands::CommandContainer
      command(:kick, help_available: false,
              permission_level: 2, permission_message: false) do |event, user, *reason|

        next "\\:exclamation: go!kick [user] [reason]" if event.message.mentions.empty? || reason.empty?

        # event.server.kick( event.message.mentions.first.on( event.server ) )
        user = event.message.mentions.first.on(event.server)

        log = Ichigobot::DB::Database::Ban.create(
            event: :kick,
            user: user.distinct,
            user_id: user.id,
            moderator: event.user.distinct,
            moderator_id: event.user.id,
            server_id: event.server.id,
            reason: reason.join(" ")
        )

        log.transparency if CONFIG["transparency"]
      end

      command(:ban, help_available: false,
              permission_level: 3, permission_message: false) do |event, user, *reason|

        next "\\:exclamation: go!ban [user] [reason]" if event.message.mentions.empty? || reason.empty?

        # event.server.kick( event.message.mentions.first.on( event.server ) )
        user = event.message.mentions.first.on(event.server)

        log = Ichigobot::DB::Database::Ban.create(
            event: :ban,
            user: user.distinct,
            user_id: user.id,
            moderator: event.user.distinct,
            moderator_id: event.user.id,
            server_id: event.server.id,
            reason: reason.join(" ")
        )

        log.transparency if CONFIG["transparency"]
      end
    end
  end
end
