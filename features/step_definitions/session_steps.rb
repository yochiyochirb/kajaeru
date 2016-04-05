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

# 投票権限があるかないかにフォーカスした step だということがわかるように書いたほうがよいかも
前提(/^以下のメンバーがログインしている:$/) do |table|
  table.hashes.each do |row|
    nickname = row.fetch('ニックネーム')
    vote_permission = row.fetch('投票権限', 'あり')
    expect(vote_permission).to be_in(%w(あり なし))

    step %(GitHub アカウント "#{nickname}" でログインしている)

    Member.find_by!(nickname: nickname).voter&.destroy if vote_permission == 'なし'
  end
end

もし(/^以下の内容で投票がある:$/) do |table|
  table.hashes.each do |row|
    voter = row.fetch('投票者')
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    using_session SecureRandom.uuid do
      steps <<-EOS
        前提 GitHub アカウント "#{voter}" でログインしている
        もし 投票ページを表示する
        かつ 以下の内容で新規投票する:
        | 投票対象     | コメント   |
        | #{candidate} | #{comment} |
        かつ サインアウトする
      EOS
    end
  end
end

もし(/^サインアウトする$/) do
  # XXX CSS class で絞り込みたい
  click_on 'サインアウト'
end
