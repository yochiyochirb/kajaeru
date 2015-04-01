# seed を作成するたびに ID をリセットする必要があるため。initializer から読ませたいところ。
module ActiveRecord
  class Base
    def self.reset_pk_sequence
      update_seq_sql = "update sqlite_sequence set seq = 0 where name = '#{table_name}';"
      ActiveRecord::Base.connection.execute(update_seq_sql)
    rescue => e
      puts e.message
    end
  end
end

# add seed data of members

Member.transaction do
  Member.delete_all
  Member.reset_pk_sequence

  members = [
    { account: 'alice',   uid: '11111', image: 'https://avatars.githubusercontent.com/u/44219?v=2' },
    { account: 'bob',     uid: '22222', image: 'https://avatars.githubusercontent.com/u/6753644?v=2' },
    { account: 'charlie', uid: '33333', image: 'https://avatars.githubusercontent.com/u/807273?v=2' },
    { account: 'john',    uid: '44444', image: 'https://avatars.githubusercontent.com/u/2962567?v=2' },
    { account: 'doe',     uid: '55555', image: 'https://avatars.githubusercontent.com/u/1832831?v=2' },
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
        klass.create!(member_id: member.id, type: "#{klass}")
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
