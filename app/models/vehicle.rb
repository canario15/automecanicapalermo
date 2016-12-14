class Vehicle < ActiveRecord::Base
  belongs_to :customer
  has_many :work_orders
  belongs_to :car_brand

  validates :car_brand, :year, :model, :plate, :color, presence: true
  validates :plate, uniqueness: true

  def to_s
    "#{car_brand} #{model} #{color}"
  end
end
