require 'socket'
require 'thread'
require 'pry'

class Hello_Server
  attr_reader :host, :port

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(@host = host, @port = port)
    @counter = 0
  end

  def run
    while client_socket = @server.accept
      request = client_socket.gets
      response = "Ola Planeta Azul (#{@counter+=1})"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{response.length}\r\n\r\n"].join("\r\n")
      client_socket.puts headers
      client_socket.puts response
      client_socket.close
     end
   end
end

server = Hello_Server.new
server.run
