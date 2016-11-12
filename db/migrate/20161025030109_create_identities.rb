class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.datetime :expires_at
      t.integer :user_id
      t.timestamps
    end
    add_index(:identities, :user_id)
    add_index(:identities, :uid)
  end
end
