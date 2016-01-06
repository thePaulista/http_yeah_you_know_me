$LOAD_PATH.unshift(File.expand_path("path",__dir__))

require 'minitest/autorun'
require 'minitest/pride'


class PathTest < Minitest::Test

  def test_that_the_class_can_be_initialized
    path = Path.new

    assert path
  end

  def test_that_the_initial_total_count_is_to_zero
    skip
    path = Path.new

  end

  def test_that_the_initial_hello_count_is_set_to_zero
    skip
    path = Path.new

  end

  def test_that_the_path_allocates_to_the_designated_paths
    skip
    path = Path.new

  end

end
