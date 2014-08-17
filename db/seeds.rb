# add seed data of members

nicknames = %w(yucao kitamuuu highwide shiraishi_ryota bonbon0605 shokola pupupopo talktome katorie)
nicknames.each do |nickname|
  Member.create(nickname: nickname, 
                provider: "github",
                uid: "#{nickname}_uid",
                image: "https://pbs.twimg.com/profile_images/3233823646/8e7ca364ecae414eb509b12915458e8f_400x400.jpeg"
               )
end
