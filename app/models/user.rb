class User < ActiveRecord::Base

  validates :name, :user_type, presence: true
  validates :name, uniqueness: true

end
