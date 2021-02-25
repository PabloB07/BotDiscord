require 'discordrb'
require 'colorize'
require 'discordrb/webhooks'
require 'json'
require 'uri'
require 'net/http'
require 'openssl'
require 'securerandom'
require 'dblruby'
require 'yaml'
require 'sqlite3'
require 'sequel'
require 'sequel_enum'

module Ichigo
  VERSION = '1.0.0'
  CONFIG = YAML.load_file("configuration.yml")
  bot = Discordrb::Commands::CommandBot.new token: CONFIG["token"], prefix: CONFIG["prefix"], client_id: CONFIG["client_id"], compress_mode: true, no_permission_message: "You don't have permissions to do that :(!", ignore_bots: true, help_command: true

bot.mention do |event|
  event.user.pm('You have mentioned me?')
end

bot.message(start_with: :game) do |event|
  # Pick a number between 1 and 10
  magic = rand(1..100)

  # Await a MessageEvent specifically from the invoking user.
  #
  # Note that since the identifier I'm using here is `:guess`,
  # only one person can be playing at one time. You can otherwise
  # interpolate something into a symbol to have multiple awaits
  # for this "command" available at the same time.
  event.user.await(:guess) do |guess_event|
    # Their message is a string - cast it to an integer
    guess = guess_event.message.content.to_i

    # If the block returns anything that *isn't* `false`, then the
    # event handler will persist and continue to handle messages.
    if guess == magic
      # This returns `nil`, which will destroy the await so we don't reply anymore
      guess_event.respond 'you win!'
    else
      # Let the user know if they guessed too high or low.
      guess_event.respond(guess > magic ? 'too high' : 'too low')

      # Return false so the await is not destroyed, and we continue to listen
      false
    end
  end

  # Let the user know we're  ready and listening..
  event.respond 'Guess a number between 1 and 100..'
end

bot.ready do |_event|
  bot.game = "In love with Hiro 4ever..! | in #{bot.servers.count} servers | go!help"
  sleep 180
  redo
end
=begin

COMMANDS OF ICHIGO BOT!

=end
bot.command :broadcast do |event, *args|
    event.channel.send_embed do |embed|
    embed.description = "#{args.join(' ')}"
    embed.colour = 0x120A8F
    end
end

bot.command :invite do |event|
   event.user.pm "#{bot.invite_url}" + 'Here is our Bot, add in your discord and enjoy!' + ' :love_letter: :fire:'
end

bot.command :sheep do |event|
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/199eeff0-af38-4f30-ae28-f447f30a78a6/d6xo4oa-6676b807-18ca-432d-826e-b4660bdca49c.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvMTk5ZWVmZjAtYWYzOC00ZjMwLWFlMjgtZjQ0N2YzMGE3OGE2XC9kNnhvNG9hLTY2NzZiODA3LTE4Y2EtNDMyZC04MjZlLWI0NjYwYmRjYTQ5Yy5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.QiwNWHYqN6P0Mucxdl2eNC7oXw_iI-Lv8l_wyGdWZJY')
    embed.colour = 0x120A8F
    end
end
bot.command :help, aliases: [:about] do |event|
  begin
    event.channel.send_embed do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://cdn.discordapp.com/app-icons/734085419255464030/4fbb07d858e970ab13ab6b532d351e10.png?size64')
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Ichigo Image taken from google")
      embed.title = 'Welcome to Ichigo Discord bot Help :helmet_with_cross:'
      embed.timestamp = Time.now
      embed.colour = 0x120A8F
      embed.description = "This bot allows you to get you many features!\n"

      embed.add_field(name: 'Ichigo Commands', value: 'Command list can be found with `go!commands`', inline: true)
      embed.add_field(name: 'Invite Ichigo to your server uwu!', value: 'You can invite Ichigo to your server with [Link](https://discordapp.com/oauth2/authorize?&client_id=734085419255464030&permissions=816&scope=bot).', inline: true)
      embed.add_field(name: 'Help Server Ichigo', value: 'Click [here](https://discord.gg/3DhBE6f) to get Help.', inline: true)
      embed.add_field(name: 'More', value: 'Run `go!more` to see more!', inline: true)
    end
  rescue Discordrb::Errors::NoPermission
    event.respond 'Well, i need permissions too :(!'
  end
end

bot.command :info, aliases: [:bot] do |event|
  begin
    event.channel.send_embed do |event|
      event.title = 'About Ichigo bot'
      event.add_field(name: 'Author', value: 'Blanco#7159 :flag_cl:', inline: true)
      event.add_field(name: 'Ichigo Version', value: bot_version, inline: true) unless bot_version == ''
      event.color = 0x120A8F
      event.timestamp = Time.now
    end
  rescue Discordrb::Errors::NoPermission
    event.respond 'I need permissions...'
  end
end

bot.command :donate do |event|
  begin
    event.channel.send_embed do |embed|
      embed.title = 'Donate to Ichigo Bot!'
      embed.description = 'for best performance, more features, etc.'
      embed.add_field(name: 'Donate', value: 'You can donate via paypal [here](https://paypal.me/pablobcl).')
      event.color = 0x120A8F
    end
  rescue Discordrb::Errors::NoPermission
    event.respond 'Hi?, i need permissions.. im here.'
  end
end


bot.command :commands do |event|
  begin
    event.channel.send_embed do |embed|
      embed.title = 'Ichigo bot commands :tools:'
      embed.colour = 0x120A8F
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://static.zerochan.net/Ichigo.%28Darling.in.the.FranXX%29.full.2281098.jpg')
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Ichigo Fanart made by @5Plus - Pixiv")
      embed.timestamp = Time.now
      embed.add_field(name: 'Basic Ichigo Commands', value: [
          '`go!help` - Find Ichigo help',
          '`go!commands` - Find Ichigo commands',
          '`go!ping` - Ping Ichigo',
          '`go!invite` - Invite Ichigo to your Community!',
          '`go!info` - Find stats about Ichigo',
          '`go!vote` - See your votes!',
          '`go!servers` - See Ichigo BOT server stats',
          '`go!region` - Get region of your Discord community/server',
          '`go!version` - See the version of Ichigo BOT'
      ].join("\n"), inline: false)

      embed.add_field(name: 'Ichigo stats Commands', value: [
          '`go!ranking` - Find Ichigo leaderboard, Add arg `all`.',
          '`go!username (name)` - Find stats for a user, leave name blank to just use your discord display name',
      ].join("\n"), inline: false)

      embed.add_field(name: 'Ichigo BOT Profile Commands', value: [
          '`go!profile` - See your profile.',
          '`go!set username (name)` - Set your username, use `go!user`.',
      ].join("\n"), inline: false)

      embed.add_field(name: 'Ichigo Extra Commands', value: [
          '`go!pat` - Pat somewhere uwu',
          '`go!answer` - Ichigo Answers, like siri (much better).',
          '`go!questions` - ¿You have a questions?, here is.',
          '`go!randompic` - Now, send randompics to all members :love_letter:'
      ].join("\n"), inline: false)
    end
  rescue Discordrb::Errors::NoPermission
    event.respond 'Hum.. i need permission, so?..'
  end
end

=begin

 bot.command :random, min_args: 0, max_args: 2, description: 'Generates a random number between 0 and 1, 0 and max or min and max.', usage: 'random [min/max] [max]' do |_event, min, max|
  if max
    rand(min.to_i..max.to_i)
  elsif min
    rand(0..min.to_i)
  else
    rand
  end
end

=end
bot.command :clear, aliases: [:remove, :delete], description: 'Clear messages!' do |event, amount|
  amount = amount.to_i
  return "You can delete only 100 messages!" if amount > 100
  event.channel.prune amount, true
  event.respond "Successfully deleted #{amount} messages 💥!"
end


puts "----------------------------------------".colorize(:blue)
puts ""
puts "Bot iniciado.".colorize(:green)
puts "Bot URL: #{bot.invite_url}&permissions=816"
puts ""
puts "----------------------------------------".colorize(:blue)

bot.run
end