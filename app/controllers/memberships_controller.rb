class MembershipsController < ApplicationController
  before_action :set_band
  before_action :require_owner!

  def index
    @memberships = @band.memberships.includes(:user)
  end

  def destroy
    membership = @band.memberships.find(params[:id])
    if membership.role == 'owner'
      redirect_to band_memberships_path(@band), alert: "Cannot remove the band owner."
    else
      membership.destroy
      redirect_to band_memberships_path(@band), notice: "Member removed."
    end
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bands_path, alert: "Band not found."
  end

  def require_owner!
    unless @band.owner?(current_user)
      redirect_to band_path(@band), alert: "Only the band owner can manage members."
    end
  end
end
