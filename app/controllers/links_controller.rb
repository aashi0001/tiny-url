class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

 
  def index
    @host = request.host_with_port
    @links = Link.all
  end


  def show

  end

  
  def new
    @link = Link.new
  end

  
  def edit
  end

  def create
    @link = Link.new(link_params)
    @link.original_url = link_params[:original_url]
    @link.censor
    if @link.new_url?
      respond_to do |format|
        if @link.save
          format.html { redirect_to root_path, notice: 'Link was successfully created.' }
          format.json { render :index, status: :created, location: @link }
        else
          format.html { render :new }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "A Tiny Url for this Link alredy exists.🙃"
      redirect_to new_link_path
    end

  end




  def update
    @link.original_url = link_params[:original_url]
    @link.censor
      respond_to do |format|
        if @link.update_attributes(original_url: link_params[:original_url])
          format.html { redirect_to root_path, notice: 'Link was successfully updated.' }
          format.json { render :index, status: :created, location: @link }
        else
          format.html { render :new }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    def set_link
      @link = Link.find(params[:id])
    end

   
    def link_params
      params.require(:link).permit(:original_url, :short_url, :censor_url, :clicks)
    end
end
