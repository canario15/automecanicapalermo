class BoxMovement < ActiveRecord::Base

  belongs_to :user
  belongs_to :currency

  validates :date, :cost_center, :desc, :value, :user, :currency, :box_movement_type, presence: true
  validates :value, numericality: true

  def self.by_month_year(days,months)
    days = days.blank? ? DAYS : days.split(",")
    months = months.blank? ? MONTH : months.split(",")
    BoxMovement.where("cast(strftime('%m', date) as int) IN (?) AND cast(strftime('%d', date) as int) IN (?) ", months , days).order(:date)
  end

end




