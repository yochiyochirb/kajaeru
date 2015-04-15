class SessionsController < ApplicationController
  def new
  end

  def callback
    if ENV['RAILS_ENV'] == 'production'
      auth = request.env['omniauth.auth']
      member = Member.find_by_provider_and_uid(auth['provider'], auth['uid'])
      if member
        session[:user_id] = member.id
        redirect_to root_path
      else
        redirect_to root_path, notice: 'You have no authorization.'
      end
    else
      # テストデータでログインするため実質認証はしていない
      session[:user_id] = 1
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to signin_path
  end
end
