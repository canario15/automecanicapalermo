class PagesController < ApplicationController
  def dashboard
    @work_order_asigned = WorkOrder.where(status: WORK_ORDER_STATUS[0] )
    @work_order_undeliver = WorkOrder.where(status: WORK_ORDER_STATUS[1] )
  end
end
