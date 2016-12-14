class BoxMovement < ActiveRecord::Base

  belongs_to :user
  belongs_to :currency
  belongs_to :work_order

  validates :date, :cost_center, :desc, :value, :user, :currency, :box_movement_type, presence: true
  validates :value, numericality: true

  before_save :remove_work_order

  def self.by_month_year(days,months)
    days = days.blank? ? DAYS : days.split(",")
    months = months.blank? ? MONTH : months.split(",")
    BoxMovement.where("cast(strftime('%m', date) as int) IN (?) AND cast(strftime('%d', date) as int) IN (?) ", months , days).order(:date)
  end


  def remove_work_order
    if cost_center != COST_CENTER_CODE[:tall] && cost_center != COST_CENTER_CODE[:cyp]
      self.work_order_id = nil
    end
  end
end




