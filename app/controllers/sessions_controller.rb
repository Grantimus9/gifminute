class SessionsController < ApplicationController
  skip_before_filter :check_logged_in_status, only: [:create]

  def create
    if auth_hash
      user = User.find_by(uid: auth_hash.uid)
      if user
        user.update_attributes!(
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          name: auth_hash.info.name,
          uid: auth_hash.uid,
          provider: auth_hash.provider,
          expires_at: expires_at
        )
      else
        user = current_user if logged_in?
        # Create the user
        user = User.create_new_user(auth_hash)
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
