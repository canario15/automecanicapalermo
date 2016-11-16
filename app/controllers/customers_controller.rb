class CustomersController < ApplicationController
before_action :set_customer, only: [:show, :edit, :update, :destroy, :delete_vehicle ]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @car_brands = CarBrand.all
  end

  # GET /customers/1/edit
  def edit
    @car_brands = CarBrand.all
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Cliente creado con éxito.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @car_brands = CarBrand.all
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'El cliente se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'El cliente se ha dado de baja correctamente' }
      format.json { head :no_content }
    end
  end

  def delete_vehicle
    vehicle = @customer.vehicles.find(params[:vehicle_id])
    vehicle.active = false
    respond_to do |format|
      if vehicle.save
        format.html { redirect_to @customer, notice: 'Se ha eliminado correctamente el vehículo.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def vehicles
    if params[:id] == "0"
      @vehicles = Vehicle.all
    else
      @vehicles = Customer.find(params[:id]).vehicles
    end
    respond_to do |format|
      if request.xhr?
        format.html { render partial: 'customers/vehicles', :layout => false}
      else
        format.html
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:owner, :invoice_name, :rut, :phone, :address, :email, vehicles_attributes: [:id, :car_brand_id, :model, :displacement, :year, :plate, :color, :chassis_number, :_destroy] )
    end
end
