class SessionsController < ApplicationController
  skip_before_action :require_to_signin, except: :destroy

  def new
  end

  # OAuth 認証時のコールバック先アクション
  # NOTE development 環境では実際には OAuth 認証は行われない
  #      詳しくは config/initializers/omniauth.rb を参照
  def callback
    auth = request.env['omniauth.auth']
    member = Member.find_by(provider: auth['provider'], uid: auth['uid'])

    if member
      session[:user_id] = member.id
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
