class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    member = Member.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Member.create_with_omniauth(auth)
    session[:user_id] = member.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
