class CarBrand < ActiveRecord::Base

  has_many :vehicles

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end
end
