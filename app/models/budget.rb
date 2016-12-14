class Budget < ActiveRecord::Base
  belongs_to :work_order

  validates :total, :subtotal_rep, :subtotal_work_does, :subtotal_rep_dol, :total_dol,  numericality: true
end
