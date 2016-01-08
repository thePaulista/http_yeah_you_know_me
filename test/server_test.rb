require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'
require 'rubygems'
require 'faraday'
require 'nokogiri'

class ServerTest < Minitest::Test
  @@server = Server.new
  @@server.start

  def setup
    @conn = Faraday.new(url: 'http://localhost:9292') do |faraday|
      faraday.request :url_encoded

      faraday.adapter Faraday.default_adapter
    end
  end

  def test_default_listening_port_is_9292

    assert_equal 9292, @@server.port
  end

  def test_default_host_is_localhost

    assert_equal "localhost", @@server.host
  end

  def test_server_responds_to_http_get
    response = @conn.get '/datetime'

    assert response.headers.length > 0
  end

  def test_server_can_ouputs_hello_and_increments
    response = @conn.get '/hello'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (1)", page.css('body')[0].text.strip

    response = @conn.get '/hello'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (2)", page.css('body')[0].text.strip

    response = @conn.get '/hello'
    page = Nokogiri::HTML(response.body)

    assert_equal "Hello World (3)", page.css('body')[0].text.strip
  end

  def test_server_outputs_status_line_is_not_404
    response = @conn.get 'status'

    refute_equal 404, response.status
  end

  def test_server_outputs_status_line_is_not_301
    response = @conn.get 'status'

    refute_equal 301, response.status
  end

  def test_server_outputs_status_line
    response = @conn.get 'status'

    assert_equal 200, response.status
  end

end
