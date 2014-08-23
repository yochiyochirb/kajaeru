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
