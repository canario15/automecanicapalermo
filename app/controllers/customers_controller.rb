class CustomersController < ApplicationController
before_action :set_customer, only: [:show, :edit, :update, :destroy, :activate, :works]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    respond_to do |format|
      format.html
      format.json { render json: CustomersDatatable.new(view_context) }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    respond_to do |format|
      if request.xhr?
        format.html { render partial: 'customers/show', :layout => false}
      else
        format.html
      end
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    respond_to do |format|
      if request.xhr?
        format.html { render partial: 'customers/new', :layout => false}
      else
        format.html
      end
    end
  end

  # GET /customers/1/edit
  def edit
    respond_to do |format|
      if request.xhr?
        format.html { render partial: 'customers/edit', :layout => false}
      else
        format.html
      end
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_url, notice: 'Cliente creado con éxito.' }
        format.json { render json: { :status =>  'OK', :message => 'Cliente creado con éxito.', :customer => @customer.to_json  } }
      else
        format.html { render action: 'new' }
        format.json { render json: { :status => 'ERROR', :errors => @customer.errors.messages } }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'El cliente se ha actualizado correctamente.' }
        format.json { render json: {:status =>  'OK', :message => 'El cliente se ha actualizado correctamente.' } }
      else
        format.html { render action: 'edit' }
        format.json { render json: { :status => 'ERROR', :errors => @customer.errors.messages } }
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



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:owner, :invoice_name, :rut, :phone, :address, :email, vehicles_attributes: [:brand, :model, :displacement, :year, :plate, :color, :chassis_number, :_destroy   ] )
    end
end
