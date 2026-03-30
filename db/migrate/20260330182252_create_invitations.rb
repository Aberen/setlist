class CreateInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :invitations do |t|
      t.references :band,        null: false, foreign_key: true
      t.string     :email,       null: false
      t.string     :token,       null: false
      t.datetime   :accepted_at
      t.timestamps
    end
    add_index :invitations, :token, unique: true
  end
end
