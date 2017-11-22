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
  end
end
