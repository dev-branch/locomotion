# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  make       :string           not null
#  model      :string           not null
#  year       :string           not null
#  vin        :string           not null
#  color      :string
#  category   :string
#  cylinders  :integer
#  mpg        :integer
#  hp         :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Car < ApplicationRecord
end
