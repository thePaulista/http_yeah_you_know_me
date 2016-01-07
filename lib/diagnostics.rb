require 'socket'

class Diagnostics

  def request_lines
    ["POST /diagnostics HTTP/1.1",
    "Host: localhost:9292",
    "Connection: keep-alive",
    "Content-Length: 146",
    "Cache-Control: no-cache",
    "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
    "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryq63vf948MVourRlF",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36",
    "Postman-Token: 0662a006-6855-3e8c-44dc-cfbd0427abe9xt/html,Mozilla/5.0,(Macintosh;,Intel,Mac,OS,X,10_10_5),AppleWebKit/537.36,(KHTML,,like,Gecko),Chrome/47.0.2526.80,Safari/537.36"]
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
    request_lines[0].split.first
  end

  def path
    request_lines[0].split[1]
  end

  def protocol
    request_lines[0].split[2]
  end

  def host
    request_lines[1].split[1].split(/:/)[0]
  end

  def port
    request_lines[1].split[1].split(/:/)[1]
  end

  def origin
    origin = host
  end

  def accept
    "text/html" + "," + request_lines[7].split[1..-1].join(",")
  end
end

puts Diagnostics.new.output_diagnostics
