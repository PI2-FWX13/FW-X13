require 'rails_helper'
include ConectionInformationsHelper

RSpec.describe MachineSettingsController, type: :controller do

  before :all do
    current_connection(ConectionInformation.first)
    @machine = MachineSetting.create(maximum_offset: 100, :maximum_size_mandril=> 80, :maximum_size_radius=> 65, conection_information_id: ConectionInformation.first.id)
  end

  describe "POST #create" do
    it "It will create a new machine settings" do
      post :create, params: {:machine_setting => {:maximum_offset=> "101", :maximum_size_mandril=> "81", :maximum_size_radius=> "66"}}
      expect(MachineSetting.count).to be(2)
    end

    it "It not will create a new machine setting" do
      post :create, params: {:machine_setting => {:maximum_offset=> 11, :maximum_size_mandril=> 12, :maximum_size_radius=> 13}}
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #show' do
  		it 'should show a webpage' do
        get :show, params:{id: @machine.id}
        expect(response).to have_http_status(200)
  		end
  end
end
