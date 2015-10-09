class GeneratedlinksController < ApplicationController
  before_action :set_generatedlink, only: [:show, :edit, :update, :destroy]

  # GET /generatedlinks
  # GET /generatedlinks.json
  def index
    @generatedlinks = Generatedlink.all
  end

  # GET /generatedlinks/1
  # GET /generatedlinks/1.json
  def show
  end

  # GET /generatedlinks/new
  def new
    @generatedlink = Generatedlink.new
  end

  # GET /generatedlinks/1/edit
  def edit
  end

  # POST /generatedlinks
  # POST /generatedlinks.json
  def create
    @generatedlink = Generatedlink.new(generatedlink_params)

    respond_to do |format|
      if @generatedlink.save
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
    # Use callbacks to share common setup or constraints between actions.
    def set_generatedlink
      @generatedlink = Generatedlink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def generatedlink_params
      params.require(:generatedlink).permit(:url, :paidout, :date)
    end
end
