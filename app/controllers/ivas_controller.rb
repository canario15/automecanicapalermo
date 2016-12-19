class IvasController < ApplicationController

  before_action :set_iva, only: [:show, :edit, :update ]

  def show
  end

  def edit
  end

  # PATCH/PUT /ivas/1
  # PATCH/PUT /ivas/1.json
  def update
    respond_to do |format|
      if @iva.update(iva_params)
        format.html { redirect_to @iva, notice: 'IVA actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @iva }
      else
        format.html { render :edit }
        format.json { render json: @iva.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iva
      @iva = Iva.find(params[:id])
    end

    # Never trust parameters from the  internet, only allow the white list through.
    def iva_params
      params.require(:iva).permit(:value)
    end
end

