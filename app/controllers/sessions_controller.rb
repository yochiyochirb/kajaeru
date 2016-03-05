class SessionsController < ApplicationController
  def new
  end

  def callback
    if Rails.env.production?
      auth = request.env['omniauth.auth']

      # NOTE 最初にバッチで GH organization のメンバーをすべて入れている前提で、新しく作ったりする
      #      ことは想定していないため、find_or_create みたいなことはしていない
      # NOTE 上記の理由から、ローカル環境で GH ログインをする際にはあらかじめバッチを実行しておく
      #      必要がある（だから wiki の開発環境構築手順にそれが書いてある）。
      #      しかし、実際のコードでは RAILS_ENV を見て分岐して、production でなければ特にそういった
      #      手順をとらなくてもログインができるように、session には無理やり id をつめている。
      #      session に手で id をつめるなら、そもそも /auth/github にいかなくていいし
      #      GH OAutn app の登録はしなくていいと思うんだけど...
      #      案としては、auth_path みたいなルーティングを作って、そのなかで RAILS_ENV を見て
      #      redirect_to '/auth/github/' に向かせるのと（production）、def set_member_info_for_dev_and_test
      #      みたいなアクションで session をつめるのと、かなあ。
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
