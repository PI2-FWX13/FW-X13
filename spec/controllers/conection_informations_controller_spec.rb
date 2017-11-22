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

  describe "GET #new" do
    it "renders the new template" do
      get :new

      expect(response).to render_template("new")
    end

    it "create new conection informations" do

      get :new

      expect(assigns(:conection_information)).to be_a(ConectionInformation)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "renders the new template" do

      c = ConectionInformation.new(:name=> "Nova Maquina3", :ip=> "10.10.10.03")
      c.save
      get :edit, params: {:id => c.id}

      expect(response).to render_template("edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do

    it "It will create a new conection informations" do
      post :create, params: {:conection_information => {:name=> "Nova Maquina2", :ip=> "10.10.10.02"}}

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(action: :index)

    end

    it "It not will create a new conection informations" do
      post :create, params: {:conection_information => {:name => "" , :ip => ""}}

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(action: :index)

    end
  end

  describe "PATCH #update" do
    it "It will update an existing objects" do

      c = ConectionInformation.new(:name=> "Nova Maquina4", :ip=> "10.10.10.04")
      c.save

      patch :update, params: {id: c.id, :conection_information => {:name => "New name"} }

      expect(ConectionInformation.find(c.id).name).to eq("New name")
    end
  end

  describe "GET #destroy" do

    it "It will delete an objects" do

      ConectionInformation.destroy_all

      c = ConectionInformation.new(:name=> "Nova Maquina4", :ip=> "10.10.10.04")
      c.save

      expect(ConectionInformation.count).to eq(1)

      get :destroy, params: {id: c.id}

      expect(ConectionInformation.count).to eq(0)
    end
  end
end
