class GeneratedlinksController < ApplicationController
  before_action :set_generatedlink, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit]
  before_action :valid_index, only: [:index]
  before_action :valid_show, only: [:show]
  

  # GET /generatedlinks
  # GET /generatedlinks.json
  def index
    #@generatedlinks = Generatedlink.all
    if(is_user_admin?)
      @generatedlinks = Generatedlink.all
    else
      @generatedlinks = Generatedlink.where("user_id =? AND paidout =?", current_user_id, false)
      # @generatedlinks.
    end
  end

  # GET /generatedlinks/1
  # GET /generatedlinks/1.json
  def show
      @generatedlink = Generatedlink.find(params[:id])
      #Adding data for access in the view...
      url = @generatedlink.url
      @todaysclicks = getTodayClicks(url)
      @weeklyclicks = getWeeklyClicks(url)
      @monthyclicks = getMonthlyClicks(url)
      @allclicks = getTotalClicks(url)
      cpm = getlinkcpm(@generatedlink)
      @todayprofit  = (@todaysclicks.to_d/1000) * cpm.to_d
      @weeklyprofit = (@weeklyclicks.to_d/1000) * cpm.to_d
      @monthylprofit= (@monthyclicks.to_d/1000) * cpm.to_d
      @allprofit = (@allclicks.to_d/1000) * cpm.to_d
      
      thumbnails = LinkThumbnailer.generate(url)
      @flavicon = thumbnails.favicon
      @thumbnail = thumbnails.images.first.src.to_s
      @sitetite  = thumbnails.title
      @sitedes   = thumbnails.description
      
      
  end

  # GET /generatedlinks/new
  def new
     @generatedlink = Generatedlink.new(:url => params[:url], :link_id => params[:link_id])
     if (!is_user_admin? && ! is_user_publisher?)
       
       @glink= @generatedlink
       @glink.user_id = current_user_id
       @glink.paidout = false
       @glink.date = DateTime.now
       patchbacklinkid= Link.where("url = ?",@generatedlink.url).first
       @glink.url = createNewShortenedLink(@generatedlink.url)
       @glink.link_id = patchbacklinkid.id
      if(@glink.save)
        patchbacklinkid.used = true
        patchbacklinkid.save
        redirect_to @generatedlink
      end
      
     end
     
     
  end

  # GET /generatedlinks/1/edit
  def edit
  end
  
  def linkdistribution 
    @generatedlink = Generatedlink.new
  end 

  # POST /generatedlinks
  # POST /generatedlinks.json
  def create
    @modified_generatedlink_params = generatedlink_params
    patchbacklinkid= Link.where("url = ?",@modified_generatedlink_params[:url]).first
    @modified_generatedlink_params[:url] = createNewShortenedLink(@modified_generatedlink_params[:url])
    @generatedlink = Generatedlink.new(@modified_generatedlink_params)
    #@generatedlink.link_id = patchbacklinkid.id
    
    

    respond_to do |format|
      if @generatedlink.save
        #Must change used flag
        patchbacklinkid.used = true
        patchbacklinkid.save
        format.html { flash[:success] = 'Generatedlink was successfully created.'; redirect_to @generatedlink }
        format.json { render :show, status: :created, location: @generatedlink }
      else
        format.html { render :new }
        format.json { render json: @generatedlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /generatedlinks/1
  # PATCH/PUT /generatedlinks/1.json
  def update
    respond_to do |format|
      if @generatedlink.update(generatedlink_params)
        format.html { flash[:success] = 'Generatedlink was successfully updated.'; redirect_to @generatedlink }
        format.json { render :show, status: :ok, location: @generatedlink }
      else
        format.html { render :edit }
        format.json { render json: @generatedlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generatedlinks/1
  # DELETE /generatedlinks/1.json
  def destroy
    @generatedlink.destroy
    respond_to do |format|
      format.html { flash[:success] = 'Generatedlink was successfully destroyed.'; redirect_to generatedlinks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions. user_id 
    def set_generatedlink
      @generatedlink = Generatedlink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def generatedlink_params
      params.require(:generatedlink).permit(:url, :paidout, :user_id, :link_id, :date)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def valid_index
      redirect_to(root_url) unless (current_user.admin? || !current_user.publisher?)
    end
    
    def valid_show
      @genlink = Generatedlink.find(params[:id])
      redirect_to(root_url) unless (current_user.admin? || current_user.id == @genlink.user_id)
    end
end
