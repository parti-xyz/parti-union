namespace :team do
  desc "빠띠의 팀원 데이터를 생성합니다."
  task 'seed' => :environment do
    Team.transaction do
      team_seed(name: '권오현',
          description: '세상이 모두에게 즐겁고 평화로운 곳이 되는데 기여하려고 잘 하든 못하든 상관없이 여러가지 일을 벌입니다.',
          profile: 'team-picture-sis.png',
          twitter: 'https://twitter.com/rest515',
          facebook: 'https://www.facebook.com/rest515',
          github: 'https://github.com/rest515')

      team_seed(name: '달리',
        description: '플랫폼 개발을 하고 있습니다. 삶에서 자급자립, 대안공동체를 고민하고 실천하고 있습니다.',
        profile: 'team-picture-dali.png',
        twitter: 'https://twitter.com/blue_spider',
        github: 'https://github.com/dalikim')

      team_seed(name: '정승구',
        description: '커뮤니티를 만드는 사람들을 돕고 있습니다. 세상을 긍정적으로 변화시키는 커뮤니티에 관심이 많습니다.',
        profile: 'team-picture-ssinkj.jpg',
        blog: 'https://medium.com/@seungkujung')

      team_seed(name: '김금진',
        description: '사람과 개를 좋아하는 빠띠의 활동가. 빠띠의 이모저모를 세상에 알립니다. 페미니즘, 조직, 먹고 사는 일, 세상을 바꾸는 기술, 데이터, 블록체인에 관심있습니다.',
        profile: 'team-picture-geumjin.jpg',
        facebook: 'https://www.facebook.com/jinjinzhenzhen',
        github: 'https://github.com/classykimpam',
        blog: 'https://medium.com/@gjkim',
        steemit: 'https://steemit.com/@classykimpam')

      team_seed(name: '성예슬',
        description: '한 개인으로 존중받으며 함께 살아가는 공동체를 지향합니다. 한 명의 목소리가 세상을 바꾼다고 믿고 있습니다. 불편한 일들에 유쾌하게 대응하는 기술을 배우는 중입니다(젠더, 페미니즘, 여성, 노동권). ',
        profile: 'team-picture-jerry.jpg',
        facebook: 'https://www.facebook.com/jjerry88',)

      team_seed(name: '장하은',
        description: '사람은 같이 살 수 밖에 없는 존재라고 생각합니다. 그 한계가 우리를 더 풍요롭게 한다고 생각하구요. 같이 더 평화롭게 살기 위해 활동합니다. 사람의 따스함을 회복하는 것, 배려와 배려를 위해 필요한 것들에 대해 궁금해합니다.',
        profile: 'team-picture-ire.jpg',)

      team_seed(name: '보리',
        description: '사람들이 자기 자신으로 존재할 수 있는 안전한 공동체를 꿈꿉니다. 영상제작, 글쓰기, 행사기획을 좋아합니다. 젠더, 노동, 이주 문제에 관심을 가지고 있습니다.',
        profile: 'team-picture-bori.jpg',
        blog: 'https://medium.com/@jy6675',
        youtube: 'https://www.youtube.com/channel/UCHS-O8-j_N9KH_IHKj-8dOQ')

      team_seed(name: '소년',
        description: '지속적으로 사회적 인격으로 살아가기 위한 최소한의 공동체, 네트워크, 커뮤니티를 형성하는 것에 관심이 있습니다. 공익적이고, 민주적인 방식의 커뮤니티 운영에 대해 고민합니다.',
        profile: 'team-picture-boyhood.png',
        blog: 'https://medium.com/@boyhood.kim')

    end
  end

  def team_seed(options)
    profile = options[:profile]
    team = Team.find_or_initialize_by profile: profile
    team.assign_attributes(options)
    team.save!
  end

end
