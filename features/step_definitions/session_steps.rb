前提(/^GitHub アカウント "([^"]*)" でログインしている$/) do |account|
  member = Member.find_by!(nickname: account)

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

前提(/^以下の投票権限のメンバーがログインしている:$/) do |table|
  table.hashes.each do |row|
    nickname = row.fetch('ニックネーム')
    vote_permission = row.fetch('投票権限', 'あり')
    expect(vote_permission).to be_in(%w(あり なし))

    step %(GitHub アカウント "#{nickname}" でログインしている)

    Member.find_by(nickname: nickname).voters.each(&:destroy) if vote_permission == 'なし'
  end
end

もし(/^サインアウトする$/) do
  find('.current-user__signout-link').click
end
