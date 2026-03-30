class AddDurationToSongs < ActiveRecord::Migration[8.1]
  def change
    add_column :songs, :duration_seconds, :integer
  end
end
