Rails.application.config.middleware.use OmniAuth::Builder do
  # NOTE 開発時に GitHub の OAuth application の登録が必須だと大変なので、
  #      development 環境では実際に認証は行わない。
  #      そのため、development 環境で動かすだけであれば、
  #      GitHub 認証をする際に必要となる ENV['GITHUB_CLIENT_ID'] と ENV['GITHUB_CLIENT_SECRET'] には
  #      token の値が入っていない状態でかまわない。
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']

  # NOTE 開発時に GitHub の OAuth application の登録が必須だと大変なので、
  #      development 環境では実際に認証はせず OmniAuth の mock 機能を利用する
  if Rails.env.development?
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: 'github',
      uid: '11111',
      info: { nickname: 'alice' }
    )
  end
end
