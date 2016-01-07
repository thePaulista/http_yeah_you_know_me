require 'socket'
require 'thread'
require 'pry'
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
          client_socket.puts output_diagnostics(request_lines)
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

  def output_diagnostics(request_lines)
    verb_value = request_lines[0].split.first
    path_value = request_lines[0].split[1]
    protocol_value = request_lines[0].split[2]
    host_value = request_lines[1].split[1].split(/:/)[0]
    port_value = request_lines[1].split[1].split(/:/)[1]
    origin_value = host_value
    accept_value = "text/html" + "," + request_lines[7].split[1..-1].join(",")
    return          ["Verb: %s" % verb_value,
                     "Path: %s" % path_value,
                    "Protocol: %s" % protocol_value,
                    "Host: %s" % host_value,
                    "Port: %s" % port_value,
                    "Origin: %s" % origin_value,
                    "Accept: %s" % accept_value
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
