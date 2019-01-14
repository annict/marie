# frozen_string_literal: true

require "discordrb"

bot = Discordrb::Bot.new(token: ENV.fetch("DISCORD_BOT_TOKEN"))

bot.message(content: "marie!") do |event|
  event.respond("なっ！")
end

bot.run
