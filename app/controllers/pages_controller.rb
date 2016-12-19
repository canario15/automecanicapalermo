class PagesController < ApplicationController
  def dashboard
    @work_order_in_work          = WorkOrder.where(status: WORK_ORDER_STATUS[0] )
    @work_order_for_deliver      = WorkOrder.where(status: WORK_ORDER_STATUS[1] )
    @work_order_payment_pendient = WorkOrder.where(status: WORK_ORDER_STATUS[2] )
    @work_order_finished         = WorkOrder.where(status: WORK_ORDER_STATUS[3] )
  end

  def help
  end

end
