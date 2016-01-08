# $LOAD_PATH.unshift(File.expand_path("diagnostics",__dir__))
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'diagnostics'
class Diagnostics_test < MiniTest::Test

  def set_up
    given1 = ["GET / HTTP/1.1",
    "Host: localhost:9292",
    "Connection: keep-alive",
    "Cache-Control: max-age=0",
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Upgrade-Insecure-Requests: 1",
    "Date: Fri, 08 Jan 2016 03:51:53 GMT",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
    "Accept-Encoding: gzip, deflate, sdch"]
  end

  def set_up2
    given2 = ["POST /Hello HTTP/1.1",
    "Host: 127.0.0.1:3000",
    "Connection: keep-alive",
    "Cache-Control: max-age=0",
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Upgrade-Insecure-Requests: 1",
    "Date: Fri, 08 Jan 2016 03:51:53 GMT",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
    "Accept-Encoding: gzip, deflate, sdch"]
  end

  def test_diagnostics_runs_verb
    given1 = Diagnostics.new(set_up)
    assert_equal "GET", given1.verb
    given2 = Diagnostics.new(set_up2)
    assert_equal "POST", given2.verb
  end

  def test_diagnostics_runs_path
    given1 = Diagnostics.new(set_up)
    assert_equal "/", given1.path
    given2 = Diagnostics.new(set_up2)
    assert_equal "/Hello", given2.path
  end

  def test_diagnostics_runs_protocol
    given1 = Diagnostics.new(set_up)
    assert_equal "HTTP/1.1", given1.protocol
    given2 = Diagnostics.new(set_up2)
    assert_equal "HTTP/1.1", given2.protocol
  end

  def test_diagnostics_runs_host
    given1 = Diagnostics.new(set_up)
    assert_equal "localhost", given1.host
    given2 = Diagnostics.new(set_up2)
    assert_equal "127.0.0.1", given2.host
  end

  def test_diagnostics_runs_port
    given1 = Diagnostics.new(set_up)
    assert_equal "9292", given1.port
    given2 = Diagnostics.new(set_up2)
    assert_equal "3000", given2.port
  end

  def test_diagnostics_runs_origin
    given1 = Diagnostics.new(set_up)
    assert_equal "localhost", given1.origin
    given2 = Diagnostics.new(set_up2)
    assert_equal "127.0.0.1", given2.origin
  end

  def test_diagnostics_accepts
    given1 = Diagnostics.new(set_up)
    assert_equal "text/html,Mozilla/5.0,(Macintosh;,Intel,Mac,OS,X,10_10_5),AppleWebKit/537.36,(KHTML,,like,Gecko),Chrome/46.0.2490.80,Safari/537.36", given1.accept
  end

end
