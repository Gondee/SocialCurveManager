class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :is_validated, only: [:destroy, :index, :edit, :update, :show ]
  # GET /linkss
  # GET /links.json
  helper :all 
  
  def index
    
    if(is_user_admin?)
      @links = Link.where("used = ?",true)
      @unusedlinks = Link.where("used = ?",false)
    elsif(is_user_publisher?)
      @links = Link.where("publisher_id = ? AND used = ?",user_publisher_id.to_s,true)
      @unusedlinks = Link.where("publisher_id = ? AND used = ?",user_publisher_id.to_s,false)
    else
      @links = Link.where("used = ?",true)
      @unusedlinks = Link.where("used = ?",false)
    end
  end
  
  def linkdistribution 
    @links = Link.paginate(page: params[:page])
  end 
  
  def _user
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end
  
  def generatenew
    @generatedlink = Generatedlink.new(:url => params[:url])
   # link = Link.find(params)
   # @generatedlink = Generatedlink.new 
   # @generatedlink.url = link.url 
   # @generatedlink.date = Date.now
   # @generatedlink.paidout = false 
   # @generatedlink.save 
  end 

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    
    #Adding the current publisher to the newly added link. 
    @pub = Publisher.find_by user_id: current_user_id
    @link.publisher_id = @pub.id
    @link.date = Date.today
    @link.used = false
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :date, :cpm, :used, :title, :category, :publisher_id)
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
    
    def is_validated
       unless(current_user.publisher?||current_user.admin?)
         redirect_to(root_url)
       end
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
