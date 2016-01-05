require 'socket'
require 'pry'

class Hello_Server

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(host, port)
    @counter = 0
  end

  def run
    while client_socket = @server.accept
      request = client_socket.gets
      # puts request   #optional for us.  not required according to specs
      response = "Ola Planeta Azul (#{@counter+=1})"
      client_socket.puts response
      client_socket.close
     end
   end
end

# server = Hello_Server.new
# server.run
