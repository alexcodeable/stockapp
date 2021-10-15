require "test_helper"

class StockControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get stock_search_url
    assert_response :success
  end
end
