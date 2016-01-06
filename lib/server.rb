require 'socket'
require 'thread'
require 'pry'

class Server

  def initialize
    @server = TCPserver.new("localhost",9292)
    count = 0
  end

  def start
    Thread.new(@server.accept) do |client|
      while true do
        request = client.get.chomp
        puts "Incoming request: #{request}"
        case request
        when diagnostics
          client.puts Diagnostics.new
        when supporting_paths
          client.start Supporting_Paths.new
        when parameters
          client.start Supporting_Parameters.new
        when games
          client.start Games.new
        when response_codes
          client.start Response.new
        end
      end
    end
  end

end


# server = TCPServer.new("localhost",9292)
# while true
#   Thread.new(server.accept) do |client|
#     Client_Side.new(client)
#   end
# end
