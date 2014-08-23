# add seed data of members

Member.transaction do
  Member.delete_all
  members = [
    { account: 'yucao',    image: 'https://pbs.twimg.com/profile_images/3233823646/8e7ca364ecae414eb509b12915458e8f_400x400.jpeg' },
    { account: 'kitamuuu', image: 'https://pbs.twimg.com/profile_images/3233823646/8e7ca364ecae414eb509b12915458e8f_normal.jpeg' },
    { account: 'highwide', image: 'https://avatars0.githubusercontent.com/u/2714316?v=2&s=400' }
  ]
  members.each do |member|
    Member.create!(
      nickname: member[:account], 
      provider: "github",
      uid: "#{member[:account]}_uid",
      image: member[:image]
    )
  end
end
