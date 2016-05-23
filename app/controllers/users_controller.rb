class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :index, :dashboard, :payment, :statistic]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,  only:    [:destroy, :index]
 # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
     @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users test add
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.activated = true; #comment to force users to verify with their email
    #@publisher = 0
    if(@user.publisher)
      @publisher = Publisher.new
      @publisher.company = publisher_params[:company]
      @publisher.position = publisher_params[:position]
    end
    
      if @user.save
        
        if @user.publisher
          @publisher.user_id = @user.id
          @publisher.save
        end
        
        @user.send_activation_email
  
        #log_in @user
        #redirect_to @user
        
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render 'new'
      end
   # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def payment
    if (is_user_admin?)
      @payments = Transaction.all
    elsif(is_user_publisher?)
      @payments = Transaction.where("user_id = ?", current_user_id)
    else
      @payments = Transaction.where("user_id = ?", current_user_id)
    end
    
  end
  
  def statistic
    
    @links = Generatedlink.where("user_id = ?", current_user_id)
    @demographic = Generatedlink.where("user_id = ?", current_user_id)
    @demographic = @demographic.order("clicks DESC").first
    
    #Stats on the Side 
    @generatedlinks = Generatedlink.where("user_id = ?", current_user_id)
      #Adding data for access in the view...
      @hoursclicks  = 0
      @todaysclicks = 0
      @weeklyclicks = 0
      @monthyclicks = 0
      @hoursprofit  = 0
      @todayprofit  = 0
      @weeklyprofit = 0
      @monthylprofit= 0
      @generatedlinks.each do |l|
        #Limiting queries
        hclicks = getTwoHoursClicks(l.url)
        tclicks = getTodayClicks(l.url)
        wclicks = getWeeklyClicks(l.url)
        mclicks = getMonthlyClicks(l.url)
        cpm = getlinkcpm(l)
        #Computing stats
        @hoursclicks  += hclicks
        @todaysclicks += tclicks
        @weeklyclicks += wclicks
        @monthyclicks += mclicks
        @hoursprofit  += ((hclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @todayprofit  += ((tclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @weeklyprofit += ((wclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @monthylprofit+= ((mclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
      end
    
    
    @dashstats = getDashboardGraphStats
    
  end

  
  # GET /dashboard
  def dashboard
    @links = Link.all 
    if (is_user_admin?)
      @generatedlinks = Generatedlink.all 
     
      
    else 
      @dashstats = getDashboardGraphStats
      #STANDARD USER
      #@generatedlinks = Generatedlink.where("user_id = ? AND created_at <= ?", current_user_id,30.days.ago)
      @generatedlinks = Generatedlink.where("user_id = ? AND created_at >= ?", current_user_id,30.days.ago)
      #Adding data for access in the view...
      @hoursclicks  = 0
      @todaysclicks = 0
      @weeklyclicks = 0
      @monthyclicks = 0
      @hoursprofit  = 0
      @todayprofit  = 0
      @weeklyprofit = 0
      @monthylprofit= 0
      @generatedlinks.each do |l|
        #Limiting queries
        hclicks = getTwoHoursClicks(l.url)
        tclicks = getTodayClicks(l.url)
        wclicks = getWeeklyClicks(l.url)
        mclicks = getMonthlyClicks(l.url)
        cpm = getlinkcpm(l)
        #Computing stats
        @hoursclicks  += hclicks
        @todaysclicks += tclicks
        @weeklyclicks += wclicks
        @monthyclicks += mclicks
        @hoursprofit  += ((hclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @todayprofit  += ((tclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @weeklyprofit += ((wclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        @monthylprofit+= ((mclicks.to_d/1000) * cpm.to_d) * ( (100 - getProfitCut() )/100)
        
        #obj = LinkThumbnailer.generate('http://stackoverflow.com')
        #@linkimage = obj.images.first.src.to_s
      end
    end 
    if(is_user_publisher?)
      @links = Link.where("publisher_id = ?",user_publisher_id.to_s)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      
      params.require(:user).permit(:first, :last, :email, :address, :url, :publisher, :password, :password_confirmation, :paypal, :cut)
      #params.permit(:first, :last, :email, :address, :url, :password, :password_confirmation, :company, :position)
    end
    
    def publisher_params
      params.require(:publisher).permit(:company, :position)
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
      redirect_to(root_url) unless (current_user?(@user) or current_user.admin?)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
