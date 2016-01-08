require 'diagnostics'

class Path
  attr_reader :total_count, :@hello_count

  def initialize
    path_allocate
    @total_count = 0
    @hello_count = 0
  end

  def path_allocate
    case path
    when "/"
      diagnostics
    when "/hello"
      hello
    when "/datetime"
      datetime
    when "/shutdown"
      shutdown
    end
  end

  def diagnostics
    @total_count += 1
    Diagnostics.new.output_diagnostics
  end

  def hello
    @total_count += 1
    puts IO.readlines("lib/hello_world.html")
     include (#{hello_count +=0})
  end

  def datetime
    @total_count += 1
    puts Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end

  def shutdown
    return "Total requests: #{@total_count}"
    abort
  end

end

#
# 1. if "/" go back to Diagnostics.new
#
# 2. if "/hello" respond with "Hello, World (0)"
# and where the counter goes up only when "/hello"
# is the path, not any other.
#
# 3. if "/datetime" respond in this format
# 11:07AM on Sunday, October November 1, 2015.
#
# 4. if "/shutdown" respond with
#   aggregate of count (so place a separate counter)
#   and exits/stops serving request.
#
# end
