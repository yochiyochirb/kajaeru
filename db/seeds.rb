# add seed data of members

nickname = %w(yucao kitamuuu highwide shiraichi_ryota bonbon0605 shokola pupupopo talktome katorie)
0.upto(8) do |m|
  Member.create(nickname: nickname[m],
                provider: "github",
                uid: m.to_s + "_" + nickname,
                image: "https://pbs.twimg.com/profile_images/3233823646/8e7ca364ecae414eb509b12915458e8f_400x400.jpeg"
               )
end
