require 'rails_helper'

RSpec.describe MachineSettingsController, type: :controller do

  before :all do
    MachineSetting.destroy_all
    MachineSetting.create! :maximum_offset=> "100", :maximum_size_mandril=> "80", :maximum_size_radius=> "65"
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
      post :create, params: {:machine_setting => {:maximum_offset=> "101", :maximum_size_mandril=> "81", :maximum_size_radius=> "66"}}

      expect(MachineSetting.count).to be(2)

    end

    it "It not will create a new machine setting" do
      post :create, params: {:machine_setting => {:maximum_offset=> 11, :maximum_size_mandril=> 12, :maximum_size_radius=> 13}}

      expect(response).to have_http_status(302)

    end
  end

  describe "PATCH #update" do
    it "It will update an existing objects" do

      m = MachineSetting.new(:maximum_offset=> 1, :maximum_size_mandril=> 2, :maximum_size_radius=> 3)
      m.save

      patch :update, params: {id: m.id, :machine_setting => {:maximum_size_mandril => 01}}
    end
  end

  describe 'Webpage index and show methods' do

  		it 'should show a webpage' do

        get :show, params:{id: MachineSetting.first.id}

        expect(response).to have_http_status(200)
  		end

  		it 'should return index view' do
  			get :index
  			expect(response).to have_http_status(200)

  		end
  	end

    describe "GET #edit" do
      it "renders the new template" do

        m = MachineSetting.new(:maximum_offset=> 5, :maximum_size_mandril=> 6, :maximum_size_radius=> 7)
        m.save
        get :edit, params: {:id => m.id}

        expect(response).to render_template("edit")
        expect(response).to have_http_status(200)
      end
    end

    describe "GET #destroy" do

      it "It will delete an objects" do

        MachineSetting.destroy_all

        m = MachineSetting.new(:maximum_offset=> 8, :maximum_size_mandril=> 9, :maximum_size_radius=> 10)
        m.save

        expect(MachineSetting.count).to eq(1)

        get :destroy, params: {id: m.id}

        expect(MachineSetting.count).to eq(0)
      end
    end
end
