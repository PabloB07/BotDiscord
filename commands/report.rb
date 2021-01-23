module Ichigobot
  module Commands
    module Report
      extend Discordrb::Commands::CommandContainer

      command(:report,
              description: "Ichigo Reports - Create a ticket.") do |event, *args|

        next "\\:exclamation: :: go!report [message]" if args.empty?

        ticket = Ichigobot::DB::Database::Ticket.create(
            user: event.user.distinct,
            user_id: event.user.id,
            server_id: event.server.id,
            content: args.join(" ")
        )

        ticket.show
      end

      command(:ticket, help_available: false,
              permission_level: 1, permission_message: false) do |_event, num, option = nil|

        next "\\:exclamation: :: go!ticket #[id] [close]" unless num

        t_number = num
        t_number = num[1..-1] if num.start_with? "#"

        ticket = Ichigobot::DB::Database::Ticket.find(id: t_number.to_i)
        next "Ticket not found." if ticket.nil?
        next ticket.show if option.nil?

        option == fechar ? ( ticket.fechar; "Ticket sended successfully!" ) : "Error, please contact an admin!"
      end

      command( :ticketr, aliases: [:ticketremove,:ticketdelete, :ticketdel], help_available: false, permission_level: 1, permission_message: false) do |event, user|

        next "\\:exclamation:  go!ticketr [user]" if event.message.mentions.empty?

        Ichigobot::DB::Database::Ticket.where(user_id: event.message.mentions.first.id).delete
      end

      command(:tickets, help_available: false,
              permission_level: 1, permission_message: false) do |event|

        ticket = Ichigobot::DB::Database::Ticket.where(status: 1).limit(10).reverse_order(:id)

        event << "```"
        ticket.each do |t|
          event << "**Ticket ##{t.id}** - for #{t.user} in #{t.created_at.strftime("%d/%m/%Y %H:%M")}."
        end
        event << "```"
      end
    end
  end
end