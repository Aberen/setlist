class Song < ApplicationRecord
  belongs_to :band
  has_many :setlist_items, dependent: :destroy
  has_many :setlist_song_notes, dependent: :destroy

  validates :title, presence: true
  validates :duration_seconds, numericality: { greater_than: 0, allow_nil: true }

  default_scope { order(:title) }

  # Format duration_seconds as "m:ss"
  def duration_formatted
    return nil unless duration_seconds.present?
    mins = duration_seconds / 60
    secs = duration_seconds % 60
    "#{mins}:#{secs.to_s.rjust(2, '0')}"
  end

  # Parse "m:ss" or "mm:ss" string into seconds
  def self.parse_duration(str)
    return nil if str.blank?
    parts = str.strip.split(':')
    return nil unless parts.length == 2
    mins = parts[0].to_i
    secs = parts[1].to_i
    return nil if secs >= 60
    (mins * 60) + secs
  end
end
