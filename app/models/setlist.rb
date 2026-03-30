class Setlist < ApplicationRecord
  belongs_to :band
  has_many :setlist_items, -> { order(:position) }, dependent: :destroy
  has_many :setlist_song_notes, dependent: :destroy

  validates :name, presence: true

  def note_for(song)
    setlist_song_notes.find_by(song: song)
  end

  def total_duration_seconds
    setlist_items.includes(:song).sum { |i| i.effective_duration_seconds.to_i }
  end

  def total_duration_formatted
    total = total_duration_seconds
    return nil if total == 0
    hours = total / 3600
    mins  = (total % 3600) / 60
    secs  = total % 60
    if hours > 0
      secs > 0 ? "#{hours}h #{mins}m #{secs}s" : "#{hours}h #{mins}m"
    elsif mins > 0
      secs > 0 ? "#{mins}m #{secs}s" : "#{mins}m"
    else
      "#{secs}s"
    end
  end

  def duration_coverage
    items = setlist_items.includes(:song)
    return 0 if items.empty?
    timed = items.count { |i| i.effective_duration_seconds.to_i > 0 }
    (timed.to_f / items.count * 100).round
  end

  # Broadcast updated list to all subscribers
  def broadcast_items_update
    items = setlist_items.includes(:song)
    ActionCable.server.broadcast(
      "setlist_#{id}",
      {
        html: ApplicationController.render(
          partial: 'setlists/items_list',
          locals: { setlist: self, items: items }
        )
      }
    )
  end
end
