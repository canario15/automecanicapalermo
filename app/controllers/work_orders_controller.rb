class WorkOrdersController < ApplicationController

  before_action :set_work_order, only: [:show, :edit, :update, :destroy, :budget, :deliver, :show_budget_pdf ]

  # GET /work_orders
  # GET /work_orders.json
  def index
    if params[:status]
      @work_orders = WorkOrder.where(status: WORK_ORDER_STATUS[params[:status].to_i])
      @title = "Ordenes de Trabajo '#{WORK_ORDER_STATUS[params[:status].to_i]}'"
    else
      @work_orders = WorkOrder.all
      @title = "Ordenes de Trabajo"
    end
  end

  # GET /work_orders/1
  # GET /work_orders/1.json
  def show
    @users = User.all
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
    @customer = Customer.new
    @customer.vehicles.build
    @car_brands = CarBrand.all
    3.times { @work_order.work_ins.build }
    @next_number = WorkOrder.maximum(:id).blank? ? 1 : WorkOrder.maximum(:id).next
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
    @users = User.all
    @customer = Customer.new
    @customer.vehicles.build
    @next_number = WorkOrder.maximum(:id).blank? ? 1 : WorkOrder.maximum(:id).next
    @car_brands = CarBrand.all
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
        if !@work_order.work_dones.blank? && @work_order.status == WORK_ORDER_STATUS[0] && !@work_order.budget.blank?
          @work_order.status = WORK_ORDER_STATUS[1]
          @work_order.save
        end
        if @work_order.status == WORK_ORDER_STATUS[1] && !@work_order.delivered_by.blank?
          @work_order.status = WORK_ORDER_STATUS[2]
          @work_order.save
        end
        format.html { redirect_to @work_order, notice: 'La orden se ha actualizada correctamente.' }
        format.json { render json: { :status =>  'success', :message => 'El presupuesto se ha guardado correctamente.' } }
      else
        format.html { render :edit }
        format.json { render json: { :status => 'error', :message => @work_order.errors.messages } }
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

  def deliver
    err = ""
    if !@work_order.budget.blank? && (!@work_order.budget.total.blank? || !@work_order.budget.total_dol.blank?)
      if @work_order.status == WORK_ORDER_STATUS[1]
        if !params[:work_order][:delivered_by_id].blank?
          @work_order.delivered_by_id = params[:work_order][:delivered_by_id]
          @work_order.status = WORK_ORDER_STATUS[2]
          @work_order.save
        else
          err = "Campo Entregado por es obligatorio"
        end
      else
        err = "La orden no aun no esta para entregar. Ingrese los tranajos y el presupuesto"
      end
    else
      err = "La orden de trabajo no tiene el presupuesto"
    end

    respond_to do |format|
      if err == ""
        format.json { render json: { :status =>  'OK', :message => 'La orden se ha entregado correctamente.' } }
      else
        format.json { render json: { :status => 'error', :message => err } }
      end
    end
  end

  def budget
    @users = User.all
    @box_movements = @work_order.box_movements
    @iva = Iva.last
    if @work_order.budget.blank?
      @work_order.budget =  Budget.new( subtotal_rep: 0, discount: 0, total_budget_pay: 0, total_budget_pay_dol: 0,subtotal_rep_dol: 0, subtotal_work_does: 0, subtotal_work_does_dol: 0, total: 0, total_dol: 0 )
    end
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
      params.require(:work_order).permit(:date_in, :deliver_date, :status, :number, :km, :fuel, :coments, :observation, :delivered_by_id, :worked_by_id, :received_by_id, :customer_id, :vehicle_id, budget_attributes: [:id, :discount, :subtotal_rep_dol, :total_dol, :subtotal_work_does, :subtotal_work_does_dol, :subtotal_rep, :total, :total_budget_pay, :total_budget_pay_dol, :subtotal, :subtotal_dol, :iva_dol, :iva ], work_ins_attributes: [:id, :work, :_destroy ], work_dones_attributes: [:id, :work, :price, :currency, :_destroy ], replacements_attributes: [:id, :name, :price, :currency, :_destroy])
    end
end


