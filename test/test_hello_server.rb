# require 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/hello_server'
require "hurley"
# require "hurley/test"

class Hello_ServerTest < Minitest::Test

  def test_TCPServer_can_be_initialized
    # skip
    server = Hello_Server.new
    wow = `curl 'http://localhost:9292'`

    assert_equal true, wow.include?("Planeta Azul") && wow.include?("200 OK")
  end

  def test_localhost_is_the_default_host
    skip
    server = Hello_Server.new

  end

  def test_that_9292_is_the_default_port
    skip
    server = Hello_Server.new

  end

  def test_that_counter_is_set_to_zero_
    skip
    server = Hello_Server.new

  end

  def test_that_counter_can_go_incrementally_up
    skip
    server = Hello_Server.new

  end

end
