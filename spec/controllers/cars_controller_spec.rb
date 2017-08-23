require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  render_views

  describe "GET /cars" do
    it "displays car index page" do
      get :index
      expect(assigns(:cars).size).to eql(3)
      expect(response.status).to eq(200)
      expect(response).to render_template("index")
      expect(response.body).to include('ToyotaCamry2015')
      expect(response.body).to include('<a href="/cars/new">New</a>')
      id = assigns(:cars).first.id
      expect(response.body).to include("<a href=\"/cars/#{id}\">#{id}</a>")
    end
  end
end
