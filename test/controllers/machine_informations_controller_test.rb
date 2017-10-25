require 'test_helper'

class MachineInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @machine_information = machine_informations(:one)
  end

  test "should get index" do
    get machine_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_machine_information_url
    assert_response :success
  end

  test "should create machine_information" do
    assert_difference('MachineInformation.count') do
      post machine_informations_url, params: { machine_information: { ip: @machine_information.ip, name: @machine_information.name } }
    end

    assert_redirected_to machine_information_url(MachineInformation.last)
  end

  test "should show machine_information" do
    get machine_information_url(@machine_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_machine_information_url(@machine_information)
    assert_response :success
  end

  test "should update machine_information" do
    patch machine_information_url(@machine_information), params: { machine_information: { ip: @machine_information.ip, name: @machine_information.name } }
    assert_redirected_to machine_information_url(@machine_information)
  end

  test "should destroy machine_information" do
    assert_difference('MachineInformation.count', -1) do
      delete machine_information_url(@machine_information)
    end

    assert_redirected_to machine_informations_url
  end
end
