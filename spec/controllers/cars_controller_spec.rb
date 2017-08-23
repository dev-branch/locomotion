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

  describe "DELETE /cars/:id" do
    it "deletes a car" do
      car = Car.first
      delete :destroy, params: {id: car.id}
      expect(response.status).to eq(302)
      expect(response).to redirect_to '/cars'
      cars = Car.where(id: car.id)
      expect(cars.size).to eql(0)
    end
  end

  describe "GET /cars/:id" do
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

  describe "GET /cars/new" do
    it "displays new car form" do
      get :new
      expect(response.status).to eq(200)
      car = assigns(:car)
      expect(car.is_a?(Car)).to be true
    end
  end

  describe "POST /cars" do
    it "creates a car" do
      post :create, params: {car: {make: 'Tesla', model: '3', year: '2018', vin: '0123456789ABCDEFG'}}
      car = assigns(:car)
      expect(car.id).to_not be_nil
      expect(response.status).to eq(302)
      expect(response).to redirect_to car
    end

    it "does not creates a car - missing vin" do
      get :create, params: {car: {make: 'Tesla', model: '3', year: '2018'}}
      car = assigns(:car)
      expect(car.id).to be_nil
      expect(response.status).to eq(200)
      expect(response).to render_template("new")
      expect(response.body).to include("<li>Vin can&#39;t be blank</li>")
    end
  end

  describe "GET /cars/:id/edit" do
    it "displays edit form" do
      car = Car.first
      get :edit, params: {id: car.id}
      expect(response.status).to eq(200)
    end
  end

  describe "PUT /cars/:id" do
    it "updates a car" do
      car1 = Car.first
      put :update, params: {id: car1.id, car: {make: 'Tesla', model: '3', year: '2018', vin: '0123456789ABCDEFG'}}
      car2 = assigns(:car)
      expect(response.status).to eq(302)
      expect(response).to redirect_to car2
    end

    it "does not update a car - no vin" do
      car1 = Car.first
      put :update, params: {id: car1.id, car: {make: 'Tesla', model: '3', year: '2018', vin: ''}}
      car2 = assigns(:car)
      expect(response.status).to eq(200)
      expect(response).to render_template("edit")
      expect(response.body).to include("<li>Vin can&#39;t be blank</li>")
    end
  end
end
