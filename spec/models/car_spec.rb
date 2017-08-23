# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  make       :string           not null
#  model      :string           not null
#  year       :integer          not null
#  vin        :string           not null
#  color      :string           default("black")
#  category   :string           default("car")
#  cylinders  :integer          default(4)
#  mpg        :integer          default(0)
#  hp         :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Car, type: :model do

  before(:each) do
    h = {make: 'Nissan', model: 'Pathfinder', year: 2017}
    Car.create(h.merge({vin: '00000000000000001'}))
    @car = Car.new(h)
  end

  describe '.new' do
    it "creates a new instance" do
      c = Car.new
      # binding.pry

      expect(c.attributes.keys.count).to eql(12)
      expect(c.is_a?(Car)).to be true
    end
  end

  describe '.create' do
    context 'all requied data present' do
      it "passes all validations" do
        c = Car.create(make: 'Toyoata', model: 'Corolla', year: 2015, vin: '00000000000000002')
        expect(c.id).to_not be_nil
        expect(c.created_at).to_not be_nil
        expect(c.updated_at).to_not be_nil
        expect(c.vin).to eql('00000000000000002')
        expect(c.cylinders).to eql(4)
        expect(c.color).to eql('black')
        expect(c.category).to eql('car')
        expect(c.mpg).to eql(0)
        expect(c.hp).to eql(0)
      end
    end

    context 'invalid data' do
      it 'fails vin check - null' do
        @car.save
        expect(@car.errors[:vin].count).to eql(1)
      end
      it 'fails vin check - shorter' do
        @car.vin = 'too short'
        @car.save
        expect(@car.errors[:vin].first).to eql("does not contain 17 alphanumeric characters")
      end
      it 'fails vin check - format' do
        @car.vin = '0000000000000000*'
        @car.save
        expect(@car.errors[:vin].first).to eql("invalid representation")
      end
      it 'fails vin check - not unique' do
        @car.vin = '00000000000000001'
        @car.save
        expect(@car.errors[:vin].first).to eql("has already been taken")
      end
      it 'fails vin check - not unique' do
        @car.vin = '00000000000000002'
        @car.save
        expect(@car.errors.full_messages.first).to eql("Make has already been taken")
      end
    end
  end
end
