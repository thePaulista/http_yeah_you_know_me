
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/controller'

class ControllerTest < MiniTest::Test

  def setup
    @controller = Controller.new
  end

  def test_controller_can_be_initialized

    assert @controller
  end

  def test_total_count_starts_at_zero

    assert_equal 0, @controller.total_count
  end

  def test_total_count_starts_at_zero

    assert_equal 0, @controller.hello_count
  end

  def test_hello_count_starts_at_zero

    assert_equal 0, @controller.hello_count
  end

  def test_it_outputs_diagnostics_given_root_path
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    output        = "Verb: GETPath: /Protocol: HTTP/1.1Host: localhostPort: 9292Origin: localhostAccept: text/html,gzip,,deflate,,sdch
"

    assert_equal output, @controller.get_content_for("/", request_lines)
  end

  def test_it_outputs_hello_given_path    #
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    output        =
    "
<html>

  <header>

      <body> Hello World (1)</body>

  </header>

</html>
"
    assert_equal output, @controller.get_content_for("/hello", request_lines)
  end

  def test_hello_count_increment_at_each_hello_count
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    assert_equal 0, @controller.hello_count
    @controller.get_content_for("/hello", request_lines)

    assert_equal 1, @controller.hello_count
    @controller.get_content_for("/hello", request_lines)

    assert_equal 2, @controller.hello_count
    @controller.get_content_for("/hello", request_lines)

    assert_equal 3, @controller.hello_count
  end

  def test_it_outputs_a_string_of_datetime
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/datetime", request_lines)

    assert_equal Time.now.strftime('%l:%M%p on %A, %B %e, %Y'), c
  end

  def test_request_does_not_get_misdirected
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/yo_what_up", request_lines)

    refute_equal Time.now.strftime('%l:%M%p on %A, %B %e, %Y'), c
  end

  def test_error_request_gets_raised
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/yo_what_up", request_lines)

    assert_equal "Path not recognized: /yo_what_up", c
  end

  def test_on_shutdown_count_gives_a_total_count
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/shutdown", request_lines)

    assert_equal "Total requests: 1", c

    @controller.get_content_for("/", request_lines)
    @controller.get_content_for("/", request_lines)
    @controller.get_content_for("/", request_lines)
    @controller.get_content_for("/", request_lines)

    c = @controller.get_content_for("/shutdown", request_lines)

    assert_equal "Total requests: 6", c
  end

  def test_total_count_is_different_from_hello_count
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/shutdown", request_lines)

    assert_equal "Total requests: 1", c

    c = @controller.get_content_for("/hello", request_lines)

    assert_equal 1, @controller.hello_count

    @controller.get_content_for("/hello", request_lines)
    assert_equal 2, @controller.hello_count

    @controller.get_content_for("/", request_lines)
    @controller.get_content_for("/", request_lines)
    @controller.get_content_for("/", request_lines)

    c = @controller.get_content_for("/shutdown", request_lines)

    assert_equal "Total requests: 7", c
  end

  def test_word_can_be_validated_on_parameters
    request_lines = ["GET /word_search?word=mean HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/word_search", request_lines)

    assert_equal "mean is a known word", c
  end

  def test_capitalized_lettered_word_can_be_validated_on_parameters
    request_lines = ["GET /word_search?word=BaNanA HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/word_search", request_lines)

    assert_equal "BaNanA is a known word", c
  end

  def test_non_words_can_be_searched_against_dictionary
    request_lines = ["GET /word_search?word=awshucks HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/word_search", request_lines)

    assert_equal "awshucks is not a known word", c
  end

  def test_another_non_words_can_be_searched_against_dictionary
    request_lines = ["GET /word_search?word=thisserveralmostdidntmakeit HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/word_search", request_lines)

    assert_equal "thisserveralmostdidntmakeit is not a known word", c
  end

  def test_bleeped_words_can_be_searched_against_dictionary
    request_lines = ["GET /word_search?word=&#@!! HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection:keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    c = @controller.get_content_for("/word_search", request_lines)

    assert_equal "&\#@!! is not a known word", c
  end

end
