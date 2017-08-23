require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  render_views

  describe "GET /cars" do
    it "displays car index page" do
      get :index
      assigns(:cars)
    end
  end
end
