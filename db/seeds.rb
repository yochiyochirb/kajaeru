# add seed data of members

Member.transaction do
  Member.delete_all
  members = [
    { account: 'tatsuo',          uid: '44219',   image: 'https://avatars.githubusercontent.com/u/44219?v=2' },
    { account: 'ikepon',          uid: '6753644', image: 'https://avatars.githubusercontent.com/u/6753644?v=2' },
    { account: 'microgravity',    uid: '807273',  image: 'https://avatars.githubusercontent.com/u/807273?v=2' },
    { account: 'mist-dev',        uid: '2962567', image: 'https://avatars.githubusercontent.com/u/2962567?v=2' },
    { account: 'kanpou0108',      uid: '1832831', image: 'https://avatars.githubusercontent.com/u/1832831?v=2' },
    { account: 'selmertsx',       uid: '1563239', image: 'https://avatars.githubusercontent.com/u/1563239?v=2' },
    { account: 'harapeko',        uid: '1858578', image: 'https://avatars.githubusercontent.com/u/1858578?v=2' },
    { account: 'tarohikeno',      uid: '1391249', image: 'https://avatars.githubusercontent.com/u/1391249?v=2' },
    { account: 'koyama777wataru', uid: '4593021', image: 'https://avatars.githubusercontent.com/u/4593021?v=2' },
    { account: 'shokola',         uid: '4434110', image: 'https://avatars.githubusercontent.com/u/4434110?v=2' },
    { account: 'imaginaryset',    uid: '6557186', image: 'https://avatars.githubusercontent.com/u/6557186?v=2' },
    { account: 'lobster7',        uid: '6521849', image: 'https://avatars.githubusercontent.com/u/6521849?v=2' },
    { account: 'ManabuSeki',      uid: '7938885', image: 'https://avatars.githubusercontent.com/u/7938885?v=2' },
    { account: 'clapyourhouse',   uid: '2536422', image: 'https://avatars.githubusercontent.com/u/2536422?v=2' },
    { account: 'reahat',          uid: '6085084', image: 'https://avatars.githubusercontent.com/u/6085084?v=2' },
    { account: 'phimcall',        uid: '6114214', image: 'https://avatars.githubusercontent.com/u/6114214?v=2' },
    { account: 'umekumi',         uid: '3304524', image: 'https://avatars.githubusercontent.com/u/3304524?v=2' },
    { account: 'axross',          uid: '4289883', image: 'https://avatars.githubusercontent.com/u/4289883?v=2' },
    { account: 'marcoball',       uid: '7622190', image: 'https://avatars.githubusercontent.com/u/7622190?v=2' },
    { account: 'shitake4',        uid: '8196476', image: 'https://avatars.githubusercontent.com/u/8196476?v=2' },
    { account: 'shin-chang',      uid: '3692503', image: 'https://avatars.githubusercontent.com/u/3692503?v=2' },
    { account: 'kswbr',           uid: '1195508', image: 'https://avatars.githubusercontent.com/u/1195508?v=2' },
    { account: 'hashcc',          uid: '4290598', image: 'https://avatars.githubusercontent.com/u/4290598?v=2' },
    { account: 'jiikko',          uid: '1664497', image: 'https://avatars.githubusercontent.com/u/1664497?v=2' },
    { account: 'ryotashiraishi',  uid: '6065862', image: 'https://avatars.githubusercontent.com/u/6065862?v=2' },
    { account: 'iberianpig',      uid: '1710555', image: 'https://avatars.githubusercontent.com/u/1710555?v=2' },
    { account: 'issy-s16',        uid: '730772',  image: 'https://avatars.githubusercontent.com/u/730772?v=2' },
    { account: 'stshsmt',         uid: '5877160', image: 'https://avatars.githubusercontent.com/u/5877160?v=2' },
    { account: 'shrimp78',        uid: '1631899', image: 'https://avatars.githubusercontent.com/u/1631899?v=2' },
    { account: 'highwide',        uid: '1495423', image: 'https://avatars.githubusercontent.com/u/1495423?v=2' },
    { account: 'maruyu0622',      uid: '6984492', image: 'https://avatars.githubusercontent.com/u/6984492?v=2' },
    { account: 'yuki3738',        uid: '6305192', image: 'https://avatars.githubusercontent.com/u/6305192?v=2' },
    { account: 'yum8686',         uid: '1001782', image: 'https://avatars.githubusercontent.com/u/1001782?v=2' },
    { account: 'ta1kt0me',        uid: '1412864', image: 'https://avatars.githubusercontent.com/u/1412864?v=2' },
    { account: 'akinomaeni',      uid: '1503693', image: 'https://avatars.githubusercontent.com/u/1503693?v=2' },
    { account: 'to0526',          uid: '1925244', image: 'https://avatars.githubusercontent.com/u/1925244?v=2' },
    { account: 'bonbon0605',      uid: '2714316', image: 'https://avatars.githubusercontent.com/u/2714316?v=2' },
    { account: 'pupupopo',        uid: '6085081', image: 'https://avatars.githubusercontent.com/u/6085081?v=2' },
    { account: 'upinetree',       uid: '1998585', image: 'https://avatars.githubusercontent.com/u/1998585?v=2' },
    { account: 'katorie',         uid: '1438425', image: 'https://avatars.githubusercontent.com/u/1438425?v=2' },
    { account: 'odaillyjp',       uid: '1294999', image: 'https://avatars.githubusercontent.com/u/1294999?v=2' },
    { account: 'yucao24hours',    uid: '1979779', image: 'https://avatars.githubusercontent.com/u/1979779?v=2 '}
  ]
  members.each do |member|
    Member.create!(
      nickname: member[:account], 
      provider: 'github',
      uid:      member[:uid],
      image:    member[:image]
    )
  end
end

Vote.transaction do
  Vote.delete_all
  votes = [
    { voting_account: 'ManabuSeki', voted_account: 'marcoball', comment: ('あ'..'ん').to_a.join },
    { voting_account: 'maruyu0622', voted_account: 'odaillyjp', comment: '!@#$%^&*()_+-=\][{}|";:/.,<>?~`' },
    { voting_account: 'kanpou0108', voted_account: 'odaillyjp', comment: ('a'..'z').to_a.join },
    { voting_account: 'umekumi',    voted_account: 'marcoball', comment: (0..9).to_a.join },
    { voting_account: 'ikepon',     voted_account: 'odaillyjp', comment: '噂浬欺圭構蚕十申曾箪貼能表暴予禄兔喀媾彌拿杤歃濬畚秉綵臀藹觸軆鐔饅鷭偆砡' },
    { voting_account: 'axross',     voted_account: 'katorie',   comment: ('ア'..'ン').to_a.join }
  ]
  votes.each do |vote|
    Vote.create!(
      comment:        vote[:comment],
      voted_member_id:  Member.find(:first, conditions: {nickname: vote[:voted_account]}).id,
      voting_member_id: Member.find(:first, conditions: {nickname: vote[:voting_account]}).id
    )
  end
end
