class SetlistItem < ApplicationRecord
  belongs_to :setlist
  belongs_to :song, optional: true

  acts_as_list scope: :setlist

  ITEM_TYPES = %w[song comment].freeze

  validates :item_type,       inclusion: { in: ITEM_TYPES }
  validates :song,            presence: true, if: -> { item_type == 'song' }
  validates :content,         presence: true, if: -> { item_type == 'comment' }
  validates :duration_seconds, numericality: { greater_than: 0, allow_nil: true }

  def song?    = item_type == 'song'
  def comment? = item_type == 'comment'

  # Effective duration — song items use song's duration, comment items use their own
  def effective_duration_seconds
    if song?
      song&.duration_seconds
    else
      duration_seconds
    end
  end

  def duration_formatted
    return nil unless duration_seconds.present?
    mins = duration_seconds / 60
    secs = duration_seconds % 60
    "#{mins}:#{secs.to_s.rjust(2, '0')}"
  end

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
