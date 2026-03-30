class SetlistSongNote < ApplicationRecord
  belongs_to :setlist
  belongs_to :song

  validates :content, presence: true
  validates :setlist_id, uniqueness: { scope: :song_id }
end
