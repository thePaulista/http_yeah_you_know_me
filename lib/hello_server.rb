# require 'socket'
# require 'thread'
# require 'pry'
#
# class Hello_Server
#   attr_reader :host, :port
#
#   def initialize(host = "localhost", port = 9292)
#     @server = TCPServer.new(@host = host, @port = port)
#     @counter = 0
#   end
#
#   def run
#     while client_socket = @server.accept
#       request = client_socket.gets
#       response = "<html><header>Ola Planeta Azul (#{@counter+=1})</header></html>"
#       headers = ["http/1.1 200 ok",
#                 "content-length: #{response.length}\r\n\r\n"].join("\r\n")
#       client_socket.puts headers
#       client_socket.puts response
#       client_socket.close
#      end
#    end
# end
#
# server = Hello_Server.new
# server.run
