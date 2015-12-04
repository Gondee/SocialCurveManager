class StatsupdatersController < ApplicationController
  before_action :set_statsupdater, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :new]
  before_action :admin_user,  only: [:show, :edit, :update, :destroy, :new]
  
  
  # GET /statsupdaters
  # GET /statsupdaters.json
  def index
    @statsupdaters = Statsupdater.all
    DailyupdaterJob.perform_later
  end
  
  
  # GET /statsupdaters/1
  # GET /statsupdaters/1.json
  def show
  end

  # GET /statsupdaters/new
  def new
    @statsupdater = Statsupdater.new
  end

  # GET /statsupdaters/1/edit
  def edit
  end

  # POST /statsupdaters
  # POST /statsupdaters.json
  def create
    @statsupdater = Statsupdater.new(statsupdater_params)

    respond_to do |format|
      if @statsupdater.save
        format.html { redirect_to @statsupdater, notice: 'Statsupdater was successfully created.' }
        format.json { render :show, status: :created, location: @statsupdater }
      else
        format.html { render :new }
        format.json { render json: @statsupdater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statsupdaters/1
  # PATCH/PUT /statsupdaters/1.json
  def update
    respond_to do |format|
      if @statsupdater.update(statsupdater_params)
        format.html { redirect_to @statsupdater, notice: 'Statsupdater was successfully updated.' }
        format.json { render :show, status: :ok, location: @statsupdater }
      else
        format.html { render :edit }
        format.json { render json: @statsupdater.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statsupdaters/1
  # DELETE /statsupdaters/1.json
  def destroy
    @statsupdater.destroy
    respond_to do |format|
      format.html { redirect_to statsupdaters_url, notice: 'Statsupdater was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statsupdater
      @statsupdater = Statsupdater.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statsupdater_params
      params.require(:statsupdater).permit(:name, :interval)
    end
    
     # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please sign in."
        redirect_to signin_url
      end
    end
    
     # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
