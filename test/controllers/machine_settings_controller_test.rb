require 'test_helper'

class MachineSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @machine_setting = machine_settings(:one)
  end

  test "should get index" do
    get machine_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_machine_setting_url
    assert_response :success
  end

  test "should create machine_setting" do
    assert_difference('MachineSetting.count') do
      post machine_settings_url, params: { machine_setting: { maximum_size_mandril: @machine_setting.maximum_size_mandril, offset: @machine_setting.offset, size_radius: @machine_setting.size_radius } }
    end

    assert_redirected_to machine_setting_url(MachineSetting.last)
  end

  test "should show machine_setting" do
    get machine_setting_url(@machine_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_machine_setting_url(@machine_setting)
    assert_response :success
  end

  test "should update machine_setting" do
    patch machine_setting_url(@machine_setting), params: { machine_setting: { maximum_size_mandril: @machine_setting.maximum_size_mandril, offset: @machine_setting.offset, size_radius: @machine_setting.size_radius } }
    assert_redirected_to machine_setting_url(@machine_setting)
  end

  test "should destroy machine_setting" do
    assert_difference('MachineSetting.count', -1) do
      delete machine_setting_url(@machine_setting)
    end

    assert_redirected_to machine_settings_url
  end
end
