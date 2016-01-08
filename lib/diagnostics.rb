require 'socket'

class Diagnostics

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def output_diagnostics
  return        ["Verb: %s" % verb,
                 "Path: %s" % path,
                "Protocol: %s" % protocol,
                "Host: %s" % host,
                "Port: %s" % port,
                "Origin: %s" % origin,
                "Accept: %s" % accept
    ]
  end

  def verb
    @request_lines[0].split.first
  end

  def path
    @request_lines[0].split[1]
  end

  def protocol
    @request_lines[0].split[2]
  end

  def host
    @request_lines[1].split[1].split(/:/)[0]
  end

  def port
    @request_lines[1].split[1].split(/:/)[1]
  end

  def origin
    origin = host
  end

  def accept
    "text/html" + "," + @request_lines[7].split[1..-1].join(",")
  end
end

# puts Diagnostics.new.output_diagnostics
