class SessionsController < ApplicationController
  def new
  end

  def callback
    auth = request.env['omniauth.auth']
    member = Member.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if member
      session[:user_id] = member.id if member
      redirect_to root_path
    else
      redirect_to root_path, notice: 'You have no authorization.'
    end
    
  end

  def destroy
    reset_session
    redirect_to signin_path
  end
end
