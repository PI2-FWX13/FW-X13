require 'rails_helper'

RSpec.describe ConectionInformationsController, type: :controller do

  before :all do
    ConectionInformation.destroy_all
    ConectionInformation.create! :name=> "Nova Maquina", :ip=> "10.10.10.01"
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end

    it "create new conection informations" do
      ci = ConectionInformation.all

      get :index

      expect(assigns(:conection_informations)).to eq(ci)
    end
  end
end
