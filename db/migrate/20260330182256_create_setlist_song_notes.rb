class CreateSetlistSongNotes < ActiveRecord::Migration[8.1]
  def change
    create_table :setlist_song_notes do |t|
      t.references :setlist, null: false, foreign_key: true
      t.references :song,    null: false, foreign_key: true
      t.text       :content, null: false
      t.timestamps
    end
    add_index :setlist_song_notes, [:setlist_id, :song_id], unique: true
  end
end
