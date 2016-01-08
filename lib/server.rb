require 'socket'
require 'thread'
require_relative 'controller'

class Server
  attr_reader :host, :port

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(@host = host, @port = port)
  end

  def start
    Thread.new {
      controller = Controller.new
      while true do
        client_socket = @server.accept
        request_lines = []
        while line = client_socket.gets and !line.chomp.empty?
          request_lines << line.chomp
        end
        first_line = request_lines.first
        # puts "Incoming request: #{first_line}"
        path = first_line.split[1].split('?')[0]
        content = controller.get_content_for(path, request_lines)
        client_socket.puts "HTTP/1.1 200 OK"
        client_socket.puts content
        client_socket.close
        exit if path == "/shutdown"
      end
    }
  end

end

if __FILE__ == $0
  server = Server.new
  server.start.join
end
