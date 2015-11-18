class GeneratedlinksController < ApplicationController
  before_action :set_generatedlink, only: [:show, :edit, :update, :destroy]

  # GET /generatedlinks
  # GET /generatedlinks.json
  def index
    #@generatedlinks = Generatedlink.all
    if(is_user_admin?)
      @generatedlinks = Generatedlink.all
    else
      @generatedlinks = Generatedlink.where("user_id =?", current_user_id)
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
     @generatedlink = Generatedlink.new(:url => params[:url])
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
    @generatedlink.link_id = patchbacklinkid.id
    
    

    respond_to do |format|
      if @generatedlink.save
        #Must change used flag
        patchbacklinkid.used = true
        patchbacklinkid.save
        format.html { redirect_to @generatedlink, notice: 'Generatedlink was successfully created.' }
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
        format.html { redirect_to @generatedlink, notice: 'Generatedlink was successfully updated.' }
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
      format.html { redirect_to generatedlinks_url, notice: 'Generatedlink was successfully destroyed.' }
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
      params.require(:generatedlink).permit(:url, :paidout, :user_id, :date)
    end
end
