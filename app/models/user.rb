class User < ActiveRecord::Base

  devise :database_authenticatable

  validates :name, :user_type, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end

end
