require 'socket'
require 'pry'

class Hello_Server

  def initialize(x = "localhost", y = 9292)
    @server = TCPServer.new(x, y)
    @counter = 0
  end

  def runner
    while socket = @server.accept
      request = socket.gets
      response1 = "Ola Planeta Azul (#{@counter+=1})"
      socket.puts response1
      socket.close
     end
   end
end

# server = Hello_Server.new
# server.runner
