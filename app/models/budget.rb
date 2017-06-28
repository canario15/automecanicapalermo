class Budget < ActiveRecord::Base
  belongs_to :work_order

  validates :total, :subtotal_rep, :subtotal_work_does, :subtotal_rep_dol, :total_dol,  numericality: true

  def any_total
    if total_budget_pay_dol != 0
      "U$S #{total_budget_pay_dol}"
    else
      if total_budget_pay != 0
        "$ #{total_budget_pay}"
      end
    end
  end

  def done_total
    if total_dol != 0
      "U$S #{total_dol}"
    else
      if total != 0
        "$ #{total}"
      end
    end
  end
end
