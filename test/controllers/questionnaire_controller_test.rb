require "test_helper"

class QuestionnaireControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get questionnaire_index_url
    assert_response :success
  end
end
