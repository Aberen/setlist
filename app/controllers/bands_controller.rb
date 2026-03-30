class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]
  before_action :require_owner!, only: [:edit, :update, :destroy]

  def index
    @bands = current_user.bands.includes(:owner, :memberships)
  end

  def show
    @members  = @band.members
    @songs    = @band.songs
    @setlists = @band.setlists
    @pending_invitations = @band.invitations.pending
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.owner = current_user
    Band.transaction do
      if @band.save
        Membership.create!(user: current_user, band: @band, role: 'owner')
        redirect_to @band, notice: "Band \"#{@band.name}\" created!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @band.update(band_params)
      redirect_to @band, notice: "Band updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @band.destroy
    redirect_to bands_path, notice: "Band deleted."
  end

  private

  def set_band
    @band = current_user.bands.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bands_path, alert: "Band not found."
  end

  def require_owner!
    unless @band.owner?(current_user)
      redirect_to @band, alert: "Only the band owner can do that."
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
