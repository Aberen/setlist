class SetlistChannel < ApplicationCable::Channel
  def subscribed
    setlist = find_setlist
    if setlist
      stream_from "setlist_#{setlist.id}"
    else
      reject
    end
  end

  def unsubscribed
    stop_all_streams
  end

  private

  def find_setlist
    Setlist.joins(band: :memberships)
           .where(memberships: { user_id: current_user.id })
           .find_by(id: params[:setlist_id])
  end
end
