class WorkOrder < ActiveRecord::Base
  belongs_to :customer
  belongs_to :vehicle
  belongs_to :user

  has_many :work_ins
  has_many :work_dones
  has_many :replacements

  accepts_nested_attributes_for :work_ins, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_dones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :replacements, reject_if: :all_blank, allow_destroy: true

end
