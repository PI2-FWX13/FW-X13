require 'test_helper'

class MandrilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mandril = mandrils(:one)
  end

  test "should get index" do
    get mandrils_url
    assert_response :success
  end

  test "should get new" do
    get new_mandril_url
    assert_response :success
  end

  test "should create mandril" do
    assert_difference('Mandril.count') do
      post mandrils_url, params: { mandril: { compriment: @mandril.compriment, radius: @mandril.radius, type: @mandril.type } }
    end

    assert_redirected_to mandril_url(Mandril.last)
  end

  test "should show mandril" do
    get mandril_url(@mandril)
    assert_response :success
  end

  test "should get edit" do
    get edit_mandril_url(@mandril)
    assert_response :success
  end

  test "should update mandril" do
    patch mandril_url(@mandril), params: { mandril: { compriment: @mandril.compriment, radius: @mandril.radius, type: @mandril.type } }
    assert_redirected_to mandril_url(@mandril)
  end

  test "should destroy mandril" do
    assert_difference('Mandril.count', -1) do
      delete mandril_url(@mandril)
    end

    assert_redirected_to mandrils_url
  end
end
