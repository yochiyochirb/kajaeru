# add seed data of members
# TODO FactoryGirl 使うようになったら、これぜんぶ factory にして、
#      FactoryGirl.create(:member)
#      みたいにインスタンスを作るコードが書いてある rake タスクを作りたいなー。
def reset_table(model)
  model.delete_all
  table_name = model.table_name

  case ActiveRecord::Base.connection.adapter_name
  when 'SQLite'
    update_seq_sql = "update sqlite_sequence set seq = 0 where name = '#{table_name}';"

    ActiveRecord::Base.connection.execute(update_seq_sql)
  when 'PostgreSQL'
    ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  else
    raise 'Only SQLite and PostgreSQL can be reset.'
  end
end

# NOTE truncate するのではなくdelete_allしてプライマリーキーだけ戻すようにする
[Member, Role].each { |klass| reset_table(klass) }

Member.transaction do
  members = [
    { account: 'alice',   uid: '11111', image: 'http://pic.prepics-cdn.com/9ece34e247cc4/54052408.jpeg' },
    { account: 'bob',     uid: '22222', image: 'http://pic.prepics-cdn.com/9ece34e247cc4/54052407.jpeg' },
    { account: 'charlie', uid: '33333', image: 'http://pic.prepics-cdn.com/9ece34e247cc4/54052406.jpeg' },
    { account: 'john',    uid: '44444', image: 'http://pic.prepics-cdn.com/aee2982c9f207/53480916.jpeg' },
    { account: 'doe',     uid: '55555', image: 'http://pic.prepics-cdn.com/aee2982c9f207/53480915.jpeg' },
  ]

  members.each do |member|
    Member.create!(
      nickname: member[:account], 
      provider: 'github',
      uid:      member[:uid],
      image:    member[:image]
    )
  end

  Member.all.map do |member|
    %w(candidate voter).map {|klass| klass.classify.constantize }
      .each do |klass|
        klass.create!(member_id: member.id)
      end
  end
end

#Vote.transaction do
#  Vote.delete_all
#  votes = [
#    { voting_account: 'ManabuSeki', voted_account: 'marcoball', comment: ('あ'..'ん').to_a.join },
#    { voting_account: 'maruyu0622', voted_account: 'odaillyjp', comment: '!@#$%^&*()_+-=\][{}|";:/.,<>?~`' },
#    { voting_account: 'kanpou0108', voted_account: 'odaillyjp', comment: ('a'..'z').to_a.join },
#    { voting_account: 'umekumi',    voted_account: 'marcoball', comment: (0..9).to_a.join },
#    { voting_account: 'ikepon',     voted_account: 'odaillyjp', comment: '噂浬欺圭構蚕十申曾箪貼能表暴予禄兔喀媾彌拿杤歃濬畚秉綵臀藹觸軆鐔饅鷭偆砡' },
#    { voting_account: 'axross',     voted_account: 'katorie',   comment: ('ア'..'ン').to_a.join }
#  ]
#  votes.each do |vote|
#    Vote.create!(
#      comment:          vote[:comment],
#      voted_member_id:  Member.find_by(nickname: vote[:voted_account]).id,
#      voting_member_id: Member.find_by(nickname: vote[:voting_account]).id
#    )
#  end
#end
