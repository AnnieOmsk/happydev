require 'test_helper'

class PaymentControllerTest < ActionController::TestCase
  test "should get demopage" do
    get :demopage
    assert_response :success
  end

end
