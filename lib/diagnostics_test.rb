# $LOAD_PATH.unshift(File.expand_path("diagnostics",__dir__))
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'diagnostics'
class Diagnostics_test < MiniTest::Test

  def test_diagnostics_runs_verb
    a = Diagnostics.new.run[0]
    assert_equal "Verb",a[0..3]
  end

  def test_diagnostics_runs_path
    a = Diagnostics.new.run[1]
    assert_equal "Path",a[0..3]
  end

  def test_diagnostics_runs_protocol
    a = Diagnostics.new.run[2]
    assert_equal "Protocol",a[0..7]
  end

  def test_diagnostics_runs_host
    a = Diagnostics.new.run[3]
    assert_equal "Host",a[0..3]
  end

  def test_diagnostics_runs_port
    a = Diagnostics.new.run[4]
    assert_equal "Port",a[0..3]
  end

  def test_diagnostics_runs_origin
    a = Diagnostics.new.run[5]
    assert_equal "Origin",a[0..5]
  end

  def test_diagnostics_accepts_texthtml
    a = Diagnostics.new.run[6]
    assert_equal "Accept",a[0..5]
    assert_equal "text/html",a[8..16]
  end

end
