require "test_helper"

class PatientControllerTest < ActionDispatch::IntegrationTest
  test "should get categorized_list" do
    get patient_categorized_list_url
    assert_response :success
  end
end
