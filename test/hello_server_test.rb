# #NOTE: started by using hurley, but after contacting the
# owner, Rick Olson, was asked not to use this gem.
# a new server test was built with the recommended faraday
# gem. Hence the test is here, but commented out.


# require 'minitest/autorun'
# require 'minitest/pride'
# require 'hurley'
#
#
#
# class Hello_Server_Test < Minitest::Test
#
#   def test_server_class_can_be_initialized
#     skip
#     response = Hurley.get("http://localhost:9292")
#     assert response.success?
#   end
#
#   def test_it_responds_server_takes_host
#     skip
#     response = Hurley.get("http://localhost:9292")
#     assert_equal 200 ,response.status_code
#   end
#
#   def test_that_content_type_is_html
#     skip
#     response = Hurley.get("http://localhost:9292")
#     assert response.header[:content_length]
#   end
#
# end
