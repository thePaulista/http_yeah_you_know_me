require 'socket'
require 'thread'
# require 'pry'
# require 'diagnostics'
# require 'supporting_paths'

class Server
  attr_reader :host, :port

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(@host = host, @port = port)
    @counter = 0
  end

  def start
    Thread.new {
      while true do
        client_socket = @server.accept
        puts "Ready for a request"
        request_lines = []
        while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end
        request_lines = client_socket.gets.chomp
        puts "Incoming request: #{request}"
        case request.split[1]
        when "/Hello_World"
          file_text = IO.readlines("lib/hello_world.html").join
          client_socket.puts file_text % (@counter += 1)
        when "/diagnostics"
          client_socket.puts output_diagnostics(request)
        # when supporting_paths
        #   client_socket.puts Supporting_Paths.new.start
        # when parameters
        #   client_socket.puts Supporting_Parameters.new
        # when games
        #   client_socket.puts Games.new
        # when response_codes
        #   client_socket.puts Response.new
      end
      client_socket.close
      end
    }
  end

  def output_diagnostics(request)

    return          ["Verb: %s" % request.split.first,
                    "Path: /",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"

    ]
  end

end

server = Server.new
server.start.join







# alternative method??
# server = TCPServer.new("localhost",9292)
# while true
#   Thread.new(server.accept) do |client|
#     Client_Side.new(client)
#   end
# end
