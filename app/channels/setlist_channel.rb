class SetlistChannel < ApplicationCable::Channel
  def subscribed
    @setlist = find_setlist
    if @setlist
      stream_from "setlist_#{@setlist.id}"
      # Add viewer after subscription confirmation
      perform(add_viewer, current_user.id, @setlist.id)
    else
      reject
    end
  end

  def unsubscribed
    perform(remove_viewer, current_user.id, @setlist&.id) if @setlist
    stop_all_streams
  end

  private

  def find_setlist
    Setlist.joins(band: :memberships)
           .where(memberships: { user_id: current_user.id })
           .find_by(id: params[:setlist_id])
  end

  def add_viewer(user_id, setlist_id)
    channel_key = "setlist_viewers_#{setlist_id}"
    
    viewers = Rails.cache.read(channel_key) || Set.new
    viewers.add(user_id)
    Rails.cache.write(channel_key, viewers, expires_in: 60)
    
    broadcast_viewer_count(setlist_id, viewers.size)
  end

  def remove_viewer(user_id, setlist_id)
    channel_key = "setlist_viewers_#{setlist_id}"
    
    viewers = Rails.cache.read(channel_key) || Set.new
    viewers.delete(user_id)
    Rails.cache.write(channel_key, viewers, expires_in: 60)
    
    broadcast_viewer_count(setlist_id, viewers.size)
  end

  def broadcast_viewer_count(setlist_id, count)
    broadcast_to(
      "setlist_#{setlist_id}",
      type: "viewer_count_update",
      viewer_count: count
    )
  end
end
