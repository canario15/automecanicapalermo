class Iva < ActiveRecord::Base
  validates :value, numericality: true
  validates :value, presence: true


  def self.value
    Iva.first.value
  end
end
