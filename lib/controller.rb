require_relative 'diagnostics'

class Controller
  attr_reader :total_count, :hello_count

  def initialize
    @total_count = 0
    @hello_count = 0
  end

  def get_content_for(path, request_lines)
    @total_count += 1
    case path
    when "/", "/diagnostics"
      diagnostics(request_lines)
    when "/hello"
      hello
    when "/datetime"
      datetime
    when "/word_search"
      word_search(request_lines)
    when "/shutdown"
      shutdown
    else
      "Path not recognized: #{path}"
    end
  end

  def diagnostics(request_lines)
    Diagnostics.new(request_lines).output_diagnostics
  end

  def hello
    file_text = IO.readlines("lib/hello_world.html").join
    file_text % (@hello_count += 1)
  end

  def datetime
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end

  def word_search(request_lines)
    word = request_lines.first.split[1].split('?')[1].split('=')[1]
    dict = IO.readlines("/usr/share/dict/words")
    if dict.include?(word.downcase + "\n")
      "#{word} is a known word"
    else
     "#{word} is not a known word"
    end
  end

  def shutdown
    "Total requests: #{@total_count}"
  end

end
