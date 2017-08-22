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
        c = Car.create(make: 'Nissan', model: 'Pathfinder', year: 2017, vin: '0123456789abcdefg')
        expect(c.id).to_not be_nil
        expect(c.created_at).to_not be_nil
        expect(c.updated_at).to_not be_nil
        expect(c.vin).to eql('0123456789ABCDEFG')
        expect(c.cylinders).to eql(4)
        expect(c.color).to eql('black')
        expect(c.category).to eql('car')
        expect(c.mpg).to eql(0)
        expect(c.hp).to eql(0)
      end
    end
  end
end
