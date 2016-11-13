class Vehicle < ActiveRecord::Base
  belongs_to :customer
  has_many :work_orders

  validates :brand, :model, :plate, :color, presence: true
  validates :plate, uniqueness: true

  def to_s
    "#{brand} #{model} #{color}"
  end
end
