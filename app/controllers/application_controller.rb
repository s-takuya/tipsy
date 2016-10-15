class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  private

  def current_user
    @_current_user ||= begin
      if (id = session[:user_id])
        User.find(id)
      end
    end
  rescue ActiveRecord::RecordNotFound
    reset_session
    redirect_to sign_in_path
  end

  def current_user=(user)
    return unless user
    session[:user_id] = user.id
    @_current_user    = user
  end

  def signed_in?
    !!current_user
  end

  def require_sign_in
    redirect_to sign_in_path unless signed_in?
  end
end
