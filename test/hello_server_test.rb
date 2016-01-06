require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require 'hurley/test'


class Hello_Server_Test < Minitest::Test

  def test_server_class_can_be_initialized
    response = Hurley.get("http://localhost:9292")

    assert response.success?
  end

  def test_it_responds_server_takes_host
    response = Hurley.get("http://localhost:9292")

    assert_equal 200 ,response.status_code
  end

end
