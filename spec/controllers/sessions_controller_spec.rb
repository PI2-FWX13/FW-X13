require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #index" do

    it "It will renders the index template" do
      get :index

      expect(response).to render_template("index")

    end
  end
end
