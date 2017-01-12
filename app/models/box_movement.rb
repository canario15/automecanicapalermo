class BoxMovement < ActiveRecord::Base

  belongs_to :user
  belongs_to :currency
  belongs_to :work_order

  validates :date, :cost_center, :desc, :value, :user, :currency, :box_movement_type, presence: true
  validates :value, numericality: true

  before_save :remove_work_order
  after_save :check_work_order_total

  def self.by_month_year(days,months)
    days = days.blank? ? DAYS : days.split(",")
    months = months.blank? ? MONTH : months.split(",")
    BoxMovement.where("Extract(month from date) IN (?) AND Extract(day from date) IN (?) ", months , days).order(:date)

  end


  def remove_work_order
    if cost_center != COST_CENTER_CODE[:tall] && cost_center != COST_CENTER_CODE[:cyp]
      self.work_order_id = nil
    end
  end

  def check_work_order_total
    if self.work_order_id != nil
      work_order = WorkOrder.find(self.work_order_id)
      box_movements = BoxMovement.where(work_order_id: self.work_order_id)
      tot_dol = 0
      tot_pes = 0
      box_movements.each do |bxm|
        if bxm.currency_id == 1
          tot_pes += bxm.value
        else
          if bxm.currency_id == 2
            tot_dol += bxm.value
          end
        end
      end
      total_debit_dol = work_order.budget.total_budget_pay - tot_pes
      total_debit_pes = work_order.budget.total_budget_pay_dol - tot_dol

      if total_debit_dol <= 0 && total_debit_pes <= 0
        work_order.status = WORK_ORDER_STATUS[3]
        work_order.save
      end
    end
  end


end




