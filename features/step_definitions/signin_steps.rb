前提(/^GitHub アカウント "([^"]*)" でログインしている$/) do |account|
  member = members(account)

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    provider: member.provider,
    uid: member.uid,
    info: {
      nickname: member.nickname
    }
  )

  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

  steps <<-EOS
    もし Kajaeru にアクセスする
    ならば サインインページが表示されていること

    もし サインインする
    ならば ホームに遷移すること
  EOS
end

もし(/^サインインする$/) do
  click_on 'Github でサインイン'
end

ならば(/^サインインページが表示されていること$/) do
  expect(current_path).to eq signin_path
end
