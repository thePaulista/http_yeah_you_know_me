require 'socket'

class Diagnostics_Server

  def initialize(host = "localhost", port = 9292)
    @server = TCPServer.new(host, port)
  end

  def run
    request_lines = ["Verb: POST",
                    "Path: /",
                    "Protocol: HTTP/1.1",
                    "Host: localhost",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"

    ]
    while client_socket = @server.accept
      request = client_socket.gets
      
      response = "<pre>" + request_lines.join("\n") + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      client_socket.puts output
      client_socket.close
    end
  end
end

server = Diagnostics_Server.new
server.run
