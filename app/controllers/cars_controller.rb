class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def destroy
    car = Car.find(params[:id])
    car.destroy
    redirect_to cars_path
  end

  def show
    @car = Car.find(params[:id])
  end
end
