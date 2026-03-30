class SetlistsController < ApplicationController
  before_action :set_band,    only: [:index, :new, :create, :destroy]
  before_action :set_setlist, only: [:show, :edit, :update]

  def all
    @bands_with_setlists = current_user.bands.includes(:setlists).sort_by(&:name)
  end

  def index
    @setlists = @band.setlists.order(:name)
  end

  def show
    @items      = @setlist.setlist_items.includes(:song)
    @band_songs = @setlist.band.songs
  end

  def new
    @setlist = @band.setlists.build
  end

  def create
    @setlist = @band.setlists.build(setlist_params)
    if @setlist.save
      redirect_to setlist_path(@setlist), notice: "Setlist \"#{@setlist.name}\" created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @setlist.update(setlist_params)
      redirect_to setlist_path(@setlist), notice: "Setlist updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @setlist.destroy
    redirect_to band_setlists_path(@band), notice: "Setlist deleted."
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bands_path, alert: "Band not found."
  end

  def set_setlist
    @setlist = Setlist.joins(band: :memberships)
                      .where(memberships: { user_id: current_user.id })
                      .find(params[:id])
    @band = @setlist.band
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Setlist not found."
  end

  def setlist_params
    params.require(:setlist).permit(:name)
  end
end
