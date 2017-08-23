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

  describe "DELETE /car/:id" do
    it "deletes a car" do
      car = Car.first
      delete :destroy, params: {id: car.id}
      expect(response.status).to eq(302)
      expect(response).to redirect_to '/cars'
      cars = Car.where(id: car.id)
      expect(cars.size).to eql(0)
    end
  end

  describe "GET /car/:id" do
    it "displays a car" do
      car = Car.first
      get :show, params: {id: car.id}
      expect(response.status).to eq(200)
      expect(assigns(:car).id).to eql(car.id)
      expect(response.body).to include(car.vin)
      expect(response.body).to include("<a href=\"/cars/#{car.id}/edit\">edit</a>")
      expect(response.body).to include("<a rel=\"nofollow\" data-method=\"delete\" href=\"/cars/#{car.id}\">delete</a>")
    end
  end
end
