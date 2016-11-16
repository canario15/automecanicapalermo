class WorkOrdersController < ApplicationController

  before_action :set_work_order, only: [:show, :edit, :update, :destroy, :budget, :finalize, :show_budget_pdf ]

  # GET /work_orders
  # GET /work_orders.json
  def index
    @work_orders = WorkOrder.all
  end

  # GET /work_orders/1
  # GET /work_orders/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf  {render pdf: "show" }
    end
  end

  # GET /work_orders/new
  def new
    @work_order = WorkOrder.new
    @customers = Customer.all
    @vehicles = Vehicle.all
    @users = User.all
    3.times { @work_order.work_ins.build }
  end

  # GET /work_orders/1/edit
  def edit
    @customers = Customer.all
    @vehicles = Vehicle.all
    @users = User.all
  end

  # POST /work_orders
  # POST /work_orders.json
  def create
    @work_order = WorkOrder.new(work_order_params)
    @customers = Customer.all
    @vehicles = Vehicle.all
    respond_to do |format|
      if @work_order.save
        @work_order.status = WORK_ORDER_STATUS[0]
        @work_order.save
        format.html { redirect_to @work_order, notice: 'Orden de trabajo creada con éxito.' }
        format.json { render :show, status: :created, location: @work_order }
      else
        format.html { render :new }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_orders/1
  # PATCH/PUT /work_orders/1.json
  def update
    @vehicles = Vehicle.all
    @users = User.all
    @customers = Customer.all
    respond_to do |format|
      if @work_order.update(work_order_params)
        if !@work_order.work_dones.blank? && @work_order.status == WORK_ORDER_STATUS[0]
          @work_order.status = WORK_ORDER_STATUS[1]
          @work_order.save
        end
        format.html { redirect_to @work_order, notice: 'La orden se ha actualizada   correctamente.' }
        format.json { render :show, status: :ok, location: @work_order }
      else
        format.html { render :edit }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_orders/1
  # DELETE /work_orders/1.json
  def destroy
    @work_order.destroy
    respond_to do |format|
      format.html { redirect_to work_orders_url, notice: 'La orden de trabajo se ha dado de baja correctamente' }
      format.json { head :no_content }
    end
  end

  def finalize
    err = ""
    if !@work_order.budget.total.blank? && !@work_order.delivered_by.blank? && @work_order.status == WORK_ORDER_STATUS[1]
      @work_order.status = WORK_ORDER_STATUS[2]
      @work_order.save
    else
      err = "La orden de trabajo no tiene el presupuesto o no tiene el empleado que entrego el vehículo"
    end
    respond_to do |format|
      if err == ""
        format.html { redirect_to @work_order, notice: 'La orden se ha finalizado correctamente.' }
      else
        format.html { redirect_to @work_order, notice: err }
      end
    end
  end

  def budget
    respond_to do |format|
      format.html
      format.pdf  {render pdf: "budget" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_order
      @work_order = WorkOrder.find(params[:id])
    end

    # Never trust parameters from the swork_ordery internet, only allow the white list through.
    def work_order_params
      params.require(:work_order).permit(:date_in, :status, :number, :km, :fuel, :coments, :delivered_by_id, :worked_by_id, :received_by_id, :customer_id, :vehicle_id, budget_attributes: [:id, :subtotal_work_does, :subtotal_rep, :total ], work_ins_attributes: [:id, :work, :_destroy ], work_dones_attributes: [:id, :work, :price, :_destroy ], replacements_attributes: [:id, :name, :price, :_destroy])
    end
end


