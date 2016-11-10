class Customer < ActiveRecord::Base
  has_many :vehicles

  validates :owner, :phone, presence: true
  validates :email, allow_blank: true, uniqueness: true
  validates :owner, :phone, uniqueness: true

  accepts_nested_attributes_for :vehicles, reject_if: :all_blank, allow_destroy: true

end
