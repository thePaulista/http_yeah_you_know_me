require 'socket'
require 'thread'
# require 'pry'
require_relative 'diagnostics'

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
        request_lines = []
        while line = client_socket.gets and !line.chomp.empty?
          request_lines << line.chomp
        end
        first_line = request_lines.first
        puts "Incoming request: #{first_line}"
        case first_line.split[1]
        when "/Hello_World"
          file_text = IO.readlines("lib/hello_world.html").join
          client_socket.puts file_text % (@counter += 1)
        when "/diagnostics"
          client_socket.puts Diagnostics.new(request_lines).output_diagnostics
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

end

if __FILE__ == $0
  server = Server.new
  server.start.join
end
