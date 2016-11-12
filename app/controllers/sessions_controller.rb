class SessionsController < ApplicationController
  skip_before_filter :check_logged_in_status, only: [:create]

  def create
    if auth_hash
      identity = Identity.where(provider: auth_hash.provider, uid: auth_hash.uid).first
      if identity
        user = User.find_by(id: identity.user_id)
        identity.update_attributes!(
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          expires_at: expires_at
        )
      else
        user = logged_in? ? current_user : User.create(name: auth_hash.info.name, email: auth_hash.info.email)
        Identity.create(
          provider: auth_hash.provider,
          uid: auth_hash.uid,
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          expires_at: expires_at,
          user_id: user.id
        )
      end
      session[:user_id] = user.id unless logged_in?
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  private

    def auth_hash
      request.env["omniauth.auth"]
    end

    # Normalizes expires_at
    def expires_at
      if auth_hash.credentials.expires_at.present?
        Time.at(auth_hash.credentials.expires_at).to_datetime
      elsif auth_hash.credentials.expires_in.present?
        DateTime.now + auth_hash.credentials.expires_in.to_i.seconds
      end
    end

end
