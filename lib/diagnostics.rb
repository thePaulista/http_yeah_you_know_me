require 'socket'

class Diagnostics

  def initialize

  end

  def run
    request_lines = ["Verb: POST",
                    "Path: /",
                    "Protocol: HTTP/1.1",
                    "Host: l127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"

    ]
  end
end

puts a = Diagnostics.new.run
