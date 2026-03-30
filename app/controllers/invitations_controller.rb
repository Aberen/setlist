class InvitationsController < ApplicationController
  before_action :set_band, only: [:new, :create]
  before_action :require_owner!, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:accept]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = @band.invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver_later
      redirect_to band_path(@band), notice: "Invitation sent to #{@invitation.email}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @invitation = Invitation.find_by!(token: params[:token])
    if @invitation.accepted?
      redirect_to root_path, notice: "This invitation has already been used."
      return
    end
    if user_signed_in?
      join_band!(@invitation, current_user)
    else
      session[:invitation_token] = params[:token]
      redirect_to new_user_session_path, notice: "Sign in or create an account to join #{@invitation.band.name}."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Invitation not found or expired."
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bands_path, alert: "Band not found."
  end

  def require_owner!
    unless @band.owner?(current_user)
      redirect_to band_path(@band), alert: "Only the band owner can send invitations."
    end
  end

  def join_band!(invitation, user)
    unless invitation.band.member?(user)
      Membership.create!(user: user, band: invitation.band, role: 'member')
    end
    invitation.update!(accepted_at: Time.current)
    redirect_to band_path(invitation.band), notice: "Welcome to #{invitation.band.name}!"
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
