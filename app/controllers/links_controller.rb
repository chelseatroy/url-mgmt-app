class LinksController < ApplicationController

  before_action :authenticate_user!

  def index
    @links = current_user.links
  end

  def show
    @links = current_user.links
    @link = current_user.links.find_by(:id => params[:id])

    unless @link
      flash[:warning] = "Link not found"
      redirect_to links_path
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(params[:link])
    @link.standardize_target_url!
    
    if @link.save
      flash[:success] = "You have a new shortlink!"
      redirect_to links_path
    else
      render 'new'
      #using redirect_to right here would clear the form. 
    end
  end

  def edit
    @link = Link.find_by(:id => params[:id])

    unless @link
      flash[:warning] = "Link not found"
      redirect_to links_path
    end
  end

  def update
    @link = Link.find_by(:id => params[:id])

    if @link && @link.update(params[:link])
      @link.standardize_target_url!
      flash[:success] = "Shortlink Updated!"
      redirect_to links_path
    else
      render 'edit'
    end
  end

  def destroy
    @link = current_user.links.find_by(:id => params[:id])
    @link.destroy

    if @link && @link.destroy
      flash[:success] = "Link destroyed successfully"
      redirect_to links_path
    else
      flash[:warning] = "Unsuccessful"
      redirect_to links_path
    end
  end

  def url_stats
    @links = current_user.links
    @link = current_user.links.find_by(:id => params[:id])

    unless @link
      flash[:warning] = "Link not found"
      redirect_to links_path
    end
  end

end
