class PaymentgroupsController < ApplicationController
  before_action :set_paymentgroup, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,  only: [:index, :show, :new, :edit, :create, :update, :destroy]
  
  # GET /paymentgroups
  # GET /paymentgroups.json
  def index
    @paymentgroups = Paymentgroup.all
  end

  # GET /paymentgroups/1
  # GET /paymentgroups/1.json
  def show
  end

  # GET /paymentgroups/new
  def new
    @paymentgroup = Paymentgroup.new
  end

  # GET /paymentgroups/1/edit
  def edit
  end

  # POST /paymentgroups
  # POST /paymentgroups.json
  def create
    @paymentgroup = Paymentgroup.new(paymentgroup_params)
    respond_to do |format|
      if @paymentgroup.save
        
        #update the generated_link to refelect that its now considered paidout. 
        genlink = Generatedlink.find_by("id = ?",@paymentgroup.generatedlink_id)
        genlink.paidout = true
        genlink.save
        
        
        format.html { redirect_to @paymentgroup, notice: 'Paymentgroup was successfully created.' }
        format.json { render :show, status: :created, location: @paymentgroup }
      else
        format.html { render :new }
        format.json { render json: @paymentgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paymentgroups/1
  # PATCH/PUT /paymentgroups/1.json
  def update
    respond_to do |format|
      if @paymentgroup.update(paymentgroup_params)
        format.html { redirect_to @paymentgroup, notice: 'Paymentgroup was successfully updated.' }
        format.json { render :show, status: :ok, location: @paymentgroup }
      else
        format.html { render :edit }
        format.json { render json: @paymentgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paymentgroups/1
  # DELETE /paymentgroups/1.json
  def destroy
    @paymentgroup.destroy
    respond_to do |format|
      format.html { redirect_to paymentgroups_url, notice: 'Paymentgroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paymentgroup
      @paymentgroup = Paymentgroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paymentgroup_params
      params.require(:paymentgroup).permit(:transaction_id, :generatedlink_id, :note)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
     # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please sign in."
        redirect_to signin_url
      end
    end
end
