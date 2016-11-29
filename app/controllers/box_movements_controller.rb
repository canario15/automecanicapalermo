class BoxMovementsController < ApplicationController
  before_action :set_box_movement, only: [:show, :edit, :update, :destroy]

  # GET /box_movements
  # GET /box_movements.json
  def index
    @box_movements = BoxMovement.by_month_year(params[:days], params[:months])
    respond_to do |format|
      if request.xhr?
        format.html { render partial: 'index_table', :layout => false}
      else
        format.html
      end
    end
  end

  # GET /box_movements/1
  # GET /box_movements/1.json
  def show
  end

  # GET /box_movements/new
  def new
    @box_movement = BoxMovement.new
    @users = User.all
    @currencies = Currency.all
  end

  # GET /box_movements/1/edit
  def edit
    @users = User.all
    @currencies = Currency.all
  end

  # POST /box_movements
  # POST /box_movements.json
  def create
    @box_movement = BoxMovement.new(box_movement_params)
    @users = User.all
    @currencies = Currency.all
    respond_to do |format|
      if @box_movement.save
        format.html { redirect_to @box_movement, notice: 'Box movement was successfully created.' }
        format.json { render :show, status: :created, location: @box_movement }
      else
        format.html { render :new }
        format.json { render json: @box_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /box_movements/1
  # PATCH/PUT /box_movements/1.json
  def update
    @users = User.all
    @currencies = Currency.all
    respond_to do |format|
      if @box_movement.update(box_movement_params)
        format.html { redirect_to @box_movement, notice: 'Box movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_movement }
      else
        format.html { render :edit }
        format.json { render json: @box_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /box_movements/1
  # DELETE /box_movements/1.json
  def destroy
    @box_movement.destroy
    respond_to do |format|
      format.html { redirect_to box_movements_url, notice: 'Box movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box_movement
      @box_movement = BoxMovement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_movement_params
      params.require(:box_movement).permit(:date, :cost_center, :desc, :value, :currency_id, :user_id, :box_movement_type)
    end
end
