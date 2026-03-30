class CreateSetlists < ActiveRecord::Migration[8.1]
  def change
    create_table :setlists do |t|
      t.references :band, null: false, foreign_key: true
      t.string     :name, null: false
      t.timestamps
    end
  end
end
