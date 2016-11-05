class SessionsController < ApplicationController
  def callback
    user = User.find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider']) do |user|
      user.name  = auth_hash['info']['name']
      user.email = auth_hash['info']['email']
      user.image = auth_hash['info']['image']
    end

    self.current_user = user
    redirect_to root_path
  end

  def failure
    reset_session
    redirect_to tags_path
  end

  def destroy
    sign_out
    redirect_to tags_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
