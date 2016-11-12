class User < ApplicationRecord

  # Create a new user object based on oauth auth_hash data.
  def self.create_new_user(auth_hash)
    self.create!(
      name: auth_hash.info.name,
      provider: auth_hash.provider,
      uid: auth_hash.uid,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
  end
end
