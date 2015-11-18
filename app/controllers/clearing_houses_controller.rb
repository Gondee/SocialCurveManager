class ClearingHousesController < ApplicationController
  before_action :set_clearing_house, only: [:show, :edit, :update, :destroy]

  # GET /clearing_houses
  # GET /clearing_houses.json
  def index
    @clearing_houses = ClearingHouse.all
    @permissions = ClearingHouse.where("user_id =?", current_user_id)
    
    #Eventually make sure they are unused
    
    
  end

  # GET /clearing_houses/1
  # GET /clearing_houses/1.json
  def show
  end

  # GET /clearing_houses/new
  def new
    @clearing_house = ClearingHouse.new
  end

  # GET /clearing_houses/1/edit
  def edit
  end

  # POST /clearing_houses
  # POST /clearing_houses.json
  def create
    @clearing_house = ClearingHouse.new(clearing_house_params)

    respond_to do |format|
      if @clearing_house.save
        format.html { redirect_to @clearing_house, notice: 'Clearing house was successfully created.' }
        format.json { render :show, status: :created, location: @clearing_house }
      else
        format.html { render :new }
        format.json { render json: @clearing_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clearing_houses/1
  # PATCH/PUT /clearing_houses/1.json
  def update
    respond_to do |format|
      if @clearing_house.update(clearing_house_params)
        format.html { redirect_to @clearing_house, notice: 'Clearing house was successfully updated.' }
        format.json { render :show, status: :ok, location: @clearing_house }
      else
        format.html { render :edit }
        format.json { render json: @clearing_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clearing_houses/1
  # DELETE /clearing_houses/1.json
  def destroy
    @clearing_house.destroy
    respond_to do |format|
      format.html { redirect_to clearing_houses_url, notice: 'Clearing house was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clearing_house
      @clearing_house = ClearingHouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clearing_house_params
      params.require(:clearing_house).permit(:publisher_id, :user_id, :note)
    end
end
