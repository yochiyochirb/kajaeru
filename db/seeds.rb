# add seed data of members

Member.transaction do
  Member.delete_all
  members = [
    { account: 'yucao',    image: 'https://avatars2.githubusercontent.com/u/1979779?v=2' },
    { account: 'kitamuuu', image: 'https://avatars0.githubusercontent.com/u/2714316?v=2' },
    { account: 'highwide', image: 'https://avatars1.githubusercontent.com/u/1495423?v=2' }
  ]
  members.each do |member|
    Member.create!(
      nickname: member[:account], 
      provider: 'github',
      uid: "#{member[:account]}_uid",
      image: member[:image]
    )
  end
end

Vote.transaction do
  Vote.delete_all
  votes = [
    { voting_member_id: '20',voted_member_id: '10', comment: ('あ'..'ん').to_a.join },
    { voting_member_id: '7',voted_member_id: '5',    comment: '!@#$%^&*()_+-=\][{}|";:/.,<>?~`' },
    { voting_member_id: '10',voted_member_id: '5',    comment: ('a'..'z').to_a.join },
    { voting_member_id: '13',voted_member_id: '10', comment: (0..9).to_a.join },
    { voting_member_id: '9',voted_member_id: '5',    comment: '噂浬欺圭構蚕十申曾箪貼能表暴予禄兔喀媾彌拿杤歃濬畚秉綵臀藹觸軆鐔饅鷭偆砡' },
    { voting_member_id: '31',voted_member_id: '17', comment: ('ア'..'ン').to_a.join }
  ]
  votes.each do |vote|
    Vote.create!(
      comment: vote[:comment],
      voted_member_id: vote[:voted_member_id],
      voting_member_id: vote[:voting_member_id]
    )
  end
end
