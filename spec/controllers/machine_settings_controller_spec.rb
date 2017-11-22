require 'rails_helper'

RSpec.describe MachineSettingsController, type: :controller do

  before :all do
    MachineSetting.destroy_all
    MachineSetting.create! :offset=> "100", :maximum_size_mandril=> "80", :size_radius=> "65"
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end

    it "create new machine setting" do
      ms = MachineSetting.all

      get :index

      expect(assigns(:machine_settings)).to eq(ms)

    end
  end

  describe "POST #create" do

    it "It will create a new machine settings" do
      post :create, params: {:machine_setting => {:offset=> "101", :maximum_size_mandril=> "81", :size_radius=> "66"}}

      expect(response).to have_http_status(302)

    end

    it "It not will create a new machine setting" do
      post :create, params: {:machine_setting => {:offset=> "", :maximum_size_mandril=> "", :size_radius=> ""}}

      expect(response).to have_http_status(302)

    end
  end

end
