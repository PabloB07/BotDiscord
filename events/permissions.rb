module Ichigo
  module Events
    module Permissions
      extend Discordrb::EventContainer
      ready do |event|
        server_roles = [
            { role: CONFIG["developer"],   permission: 4 },
            { role: CONFIG["admin"],       permission: 3 },
            { role: CONFIG["moderator"],   permission: 2 },
            { role: CONFIG["colaborator"], permission: 1 }
        ]

        server_roles.each do |roles|
          event.bot.servers.values.map(&:id).each do |server|
            next unless (role = event.bot.server(server).roles.find { |r| r.name == roles[:role] })
            bot.set_role_permission role.id, roles[:permission]
          end
        end
      end
    end
  end
  end
