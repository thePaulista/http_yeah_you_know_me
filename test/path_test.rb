$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'path'
require 'diagnostics'
class Path_test < MiniTest::Test

  def test_empty_path_leads_to_diagnostics
    skip
    a = Path.new.path_allocate("/")
    assert_equal "diagnostics", a
  end

  def test_hello_path_leads_to_greeting
   a = Path.new.path_allocate("/hello")
   assert_equal "Hello World (0)", a
  end
end
