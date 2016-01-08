require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'

require 'rubygems'
require 'faraday'
require 'nokogiri'

class ServerTest < Minitest::Test
  @@server = Server.new(host = "localhost", port = 9292).start

  def setup
    @conn = Faraday.new(url: 'http://localhost:9292') do |faraday|
      faraday.request :url_encoded
      # faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def test_default_listening_port_is_9292

    # s = @server.port

    # assert_equal 9292, s

    # response = @conn.get '/Hello_World'
    # page = Nokogiri::HTML(response.body)
    # assert_equal "Hello World (1)", page.css('body')[0].text.strip

    # response = @conn.get '/Hello_World'
    # page = Nokogiri::HTML(response.body)
    # assert_equal "Hello World (2)", page.css('body')[0].text.strip
  end

  def test_server_can_output_hello_world
    response = @conn.get '/Hello_World'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (1)", page.css('body')[0].text.strip
  end

  def test_server_can_ouput_increments
    response = @conn.get '/Hello_World'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (1)", page.css('body')[0].text.strip
    #
    # response = @conn.get '/Hello_World'
    # page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (2)", page.css('body')[0].text.strip

    response = @conn.get '/Hello_World'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (3)", page.css('body')[0].text.strip
  end

  def test_default_localhost
    skip
    s = @server.host

    assert_equal "localhost", s
  end

  def test_counter_is_started_at_zero
    skip
    s = @server.counter

    assert_equal 0, s
  end

  def test_request_line_starts_empty
    skip

  end

  def test_can_take_client_request
    skip
  end

  def test_server_can_output_hello_world
    skip
  end

  def test_hello_world_counter_increments
    skip
  end

  def test_server_can_output_diagnostics
    skip
  end

  def test_server_can_intastiate_a_path
    skip
  end

  def test_it_can_generate_a_game_class
    skip
  end

  def test_it_can_generate_a_response_code_page
    skip
  end

end
