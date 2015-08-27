require "thor"

module Toetactics
  class CLI < ::Thor
    desc "play URI GAME_ID", "try to join and play a game of tic-tac-toe"
    def play(uri, game_id)
      # uri = "ws://127.0.0.1:4000/socket/websocket?vsn=1.0.0"
      topic = "tictactoe:#{game_id}"
      client = Toetactics::Client.new(uri, topic)
      client.join

      until client.game_over? do
        puts "waiting for the game to end"
        client.move rand(0..8)
        sleep 1.0
      end
    end
  end
end
