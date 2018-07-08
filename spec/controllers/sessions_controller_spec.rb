require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end
  end

end
