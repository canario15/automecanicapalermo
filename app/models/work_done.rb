class WorkDone < ActiveRecord::Base
  belongs_to :work_order

  def  to_s
    work
  end
end
