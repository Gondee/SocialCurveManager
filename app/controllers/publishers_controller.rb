class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]
  before_action :publisher_user, only: [:show, :edit, :update, :destroy, :index]

  # GET /publishers
  # GET /publishers.json
  def index
    @publishers = Publisher.all
    redirect_to :controller => 'users', :action => 'index'
  end

  # GET /publishers/1
  # GET /publishers/1.json
  def show
    @publisher = Publisher.find(params[:id])
    @user = User.find(@publisher.user_id)
    redirect_to :controller => 'users', :action => 'show', :id => @user.id
  end

  # GET /publishers/new
  def new
    @publisher = Publisher.new
  end

  # GET /publishers/1/edit
  def edit
    @publisher = Publisher.find(params[:id])
    @user = User.find(@publisher.user_id)
    redirect_to :controller => 'users', :action => 'edit', :id => @user.id
  end

  # POST /publishers
  # POST /publishers.json
  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { flash[:success] = 'Publisher was successfully created.'; redirect_to @publisher }
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publishers/1
  # PATCH/PUT /publishers/1.json
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { flash[:success] = 'Publisher was successfully updated.'; redirect_to @publisher }
        format.json { render :show, status: :ok, location: @publisher }
      else
        format.html { render :edit }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publishers/1
  # DELETE /publishers/1.json
  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { flash[:success] = 'Publisher was successfully destroyed.'; redirect_to publishers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:first, :last, :address, :phone, :company, :position, :note)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def publisher_user
      redirect_to(root_url) unless (current_user.publisher? || current_user.admin?) 
    end
end
