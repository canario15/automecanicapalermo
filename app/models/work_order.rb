class WorkOrder < ActiveRecord::Base
  belongs_to :customer
  belongs_to :vehicle
  belongs_to :delivered_by, :class_name => 'User', :foreign_key => 'delivered_by_id'
  belongs_to :worked_by,    :class_name => 'User', :foreign_key => 'worked_by_id'
  belongs_to :received_by,  :class_name => 'User', :foreign_key => 'received_by_id'

  has_one :budget

  has_many :work_ins
  has_many :work_dones
  has_many :replacements

  accepts_nested_attributes_for :work_ins, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_dones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :replacements, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :budget

  validates :date_in, :km, :fuel, :customer, :vehicle, :work_ins, :worked_by, :received_by, presence: true


  after_create :build_budget


  private

  def build_budget
    self.budget = Budget.new(total: 0, subtotal_rep: 0, subtotal_work_does: 0)
  end
end
