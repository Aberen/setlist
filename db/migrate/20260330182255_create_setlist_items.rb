class CreateSetlistItems < ActiveRecord::Migration[8.1]
  def change
    create_table :setlist_items do |t|
      t.references :setlist,   null: false, foreign_key: true
      t.integer    :position
      t.string     :item_type, null: false
      t.references :song,      foreign_key: true
      t.text       :content
      t.timestamps
    end
    add_index :setlist_items, [:setlist_id, :position]
  end
end
