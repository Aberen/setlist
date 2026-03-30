class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern

  helper_method :current_band

  private

  def current_band
    @current_band ||= begin
      band = Band.find(params[:band_id]) if params[:band_id]
      unless band && band.member?(current_user)
        redirect_to root_path, alert: "You are not a member of that band."
        return nil
      end
      band
    end
  end

  def require_band_owner!
    unless current_band&.owner?(current_user)
      redirect_to band_path(current_band), alert: "Only the band owner can do that."
    end
  end
end
