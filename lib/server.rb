require 'socket'
require 'thread'
require 'pry'
require 'diagnostics'
require 'supporting_paths'

class Server
  attr_reader :host, :port

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(@host = host, @port = port)
    @counter = 0
  end

  def start
    Thread.new(@server.accept) do |client|
      while true do
        request = client.get.chomp
        puts "Incoming request: #{request}"
        case request
        when diagnostics
          client.puts Diagnostics.new.start
        when supporting_paths
          client.puts Supporting_Paths.new.start
        # when parameters
        #   client.start Supporting_Parameters.new
        # when games
        #   client.start Games.new
        # when response_codes
        #   client.start Response.new
        end
        client.close
      end
    end
  end
end

server = Server.new
server.start

# server = TCPServer.new("localhost",9292)
# while true
#   Thread.new(server.accept) do |client|
#     Client_Side.new(client)
#   end
# end
