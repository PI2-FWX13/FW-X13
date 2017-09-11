require 'test_helper'

class WindingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @winding = windings(:one)
  end

  test "should get index" do
    get windings_url
    assert_response :success
  end

  test "should get new" do
    get new_winding_url
    assert_response :success
  end

  test "should create winding" do
    assert_difference('Winding.count') do
      post windings_url, params: { winding: { angle: @winding.angle, density: @winding.density, filamentLength: @winding.filamentLength, filamentWidth: @winding.filamentWidth, gelPot: @winding.gelPot, layers: @winding.layers, length: @winding.length, offset: @winding.offset, radius: @winding.radius, windingdate: @winding.windingdate } }
    end

    assert_redirected_to winding_url(Winding.last)
  end

  test "should show winding" do
    get winding_url(@winding)
    assert_response :success
  end

  test "should get edit" do
    get edit_winding_url(@winding)
    assert_response :success
  end

  test "should update winding" do
    patch winding_url(@winding), params: { winding: { angle: @winding.angle, density: @winding.density, filamentLength: @winding.filamentLength, filamentWidth: @winding.filamentWidth, gelPot: @winding.gelPot, layers: @winding.layers, length: @winding.length, offset: @winding.offset, radius: @winding.radius, windingdate: @winding.windingdate } }
    assert_redirected_to winding_url(@winding)
  end

  test "should destroy winding" do
    assert_difference('Winding.count', -1) do
      delete winding_url(@winding)
    end

    assert_redirected_to windings_url
  end
end
