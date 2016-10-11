class SessionsController < ApplicationController
  def new
  end

  def callback
    user = User.find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider']) do |user|
      user.email = auth_hash['info']['email']
      user.image = auth_hash['info']['image']
    end

    self.current_user = user
    redirect_to root_path
  end

  def failure
    reset_session
    redirect_to sign_in_path
  end

  def destroy
    reset_session
    redirect_to sign_in_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
