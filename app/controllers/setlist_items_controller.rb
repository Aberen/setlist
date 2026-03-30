class SetlistItemsController < ApplicationController
  before_action :set_setlist
  before_action :set_item, only: [:update, :destroy]

  def create
    @item = @setlist.setlist_items.build(item_params)
    if @item.save
      respond_with_update
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to setlist_path(@setlist), alert: @item.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    if params.dig(:setlist_item, :position).present?
      @item.insert_at(params[:setlist_item][:position].to_i)
      respond_with_update
    elsif params[:setlist_item].present?
      if @item.update(item_params)
        respond_with_update
      else
        respond_to do |format|
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_to setlist_path(@setlist), alert: @item.errors.full_messages.to_sentence }
        end
      end
    else
      head :bad_request
    end
  end

  def destroy
    @item.destroy
    respond_with_update
  end

  private

  def respond_with_update
    @setlist.reload
    @items = @setlist.setlist_items.includes(:song)

    # Broadcast to all OTHER subscribers (other users viewing this setlist)
    @setlist.broadcast_items_update

    # Respond to the requesting user directly via Turbo Stream
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "setlist-items-content",
          partial: "setlists/items_list",
          locals: { setlist: @setlist, items: @items }
        )
      end
      format.json { render json: { status: 'ok' } }
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

  def set_item
    @item = @setlist.setlist_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to setlist_path(@setlist), alert: "Item not found."
  end

  def item_params
    raw = params.require(:setlist_item)
                .permit(:item_type, :song_id, :content, :position, :duration_input)
                .to_h
    raw['duration_seconds'] = SetlistItem.parse_duration(raw.delete('duration_input'))
    raw.compact
  end
end
