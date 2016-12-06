class Budget < ActiveRecord::Base
  belongs_to :work_order

  validates :total, :subtotal_rep, :subtotal_work_does,  numericality: true
end
