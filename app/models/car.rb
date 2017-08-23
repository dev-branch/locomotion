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

class Car < ApplicationRecord
  before_validation :upper_vin, :check_vin_size, :check_vin_chars

  validates :make, :model, :year, :vin, presence: true
  validates :vin, uniqueness: true
  validates :make, uniqueness: {scope: [:model, :year]}

  private

  def upper_vin
    self.vin = vin.upcase if vin
  end

  def check_vin_size
    errors.add(:vin, 'does not contain 17 alphanumeric characters') if vin && vin.size != 17
  end

  def check_vin_chars
    errors.add(:vin, 'invalid representation') if vin && vin !~ /^[0-9A-Z]{17}$/
  end
end
