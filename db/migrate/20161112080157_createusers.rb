class Createusers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.integer :uid, :limit => 8
      t.integer :followers_count
      t.integer :tweet_count
      t.string :token
      t.string :secret
      t.datetime :expires_at
      t.timestamps
    end
    add_index(:users, :uid)
  end
end
