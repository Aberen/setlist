class InvitationMailer < ApplicationMailer
  def invite(invitation)
    @invitation = invitation
    @band       = invitation.band
    @accept_url = accept_invitation_url(token: invitation.token)
    mail(to: invitation.email, subject: "You've been invited to join #{@band.name} on SetlistApp")
  end
end
