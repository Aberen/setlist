class SetlistSongNotesController < ApplicationController
  before_action :set_setlist
  before_action :set_note, only: [:update]

  def create
    @note = @setlist.setlist_song_notes.build(note_params)
    if @note.save
      respond_with_update
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to setlist_path(@setlist), alert: @note.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    if @note.update(note_params)
      respond_with_update
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to setlist_path(@setlist), alert: @note.errors.full_messages.to_sentence }
      end
    end
  end

  private

  def respond_with_update
    @setlist.reload
    @items = @setlist.setlist_items.includes(:song)

    # Broadcast to all other users viewing this setlist
    @setlist.broadcast_items_update

    # Respond to requesting user directly
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "setlist-items-content",
          partial: "setlists/items_list",
          locals: { setlist: @setlist, items: @items }
        )
      end
      format.html { redirect_to setlist_path(@setlist) }
    end
  end

  def set_setlist
    @setlist = Setlist.joins(band: :memberships)
                      .where(memberships: { user_id: current_user.id })
                      .find(params[:setlist_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Setlist not found."
  end

  def set_note
    @note = @setlist.setlist_song_notes.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to setlist_path(@setlist), alert: "Note not found."
  end

  def note_params
    params.require(:setlist_song_note).permit(:song_id, :content)
  end
end
