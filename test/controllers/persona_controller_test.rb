require "test_helper"

class PersonaControllerTest < ActionDispatch::IntegrationTest
  test "should get predict" do
    get persona_predict_url
    assert_response :success
  end
end
