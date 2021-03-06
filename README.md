# parti-union

## 실환경 구축 방법

각 키는 프로젝트루트/shared/config/env.yml에 등록합니다.
관리자페이지로 진입할때 쓰는 패스워드(ADMIN_PASSWORD)를 등록합니다.

S3_로 시작하는 것은 아마존 s3 관련된 정보입니다.

```
production:
  ...
  FACEBOOK_APP_ID: xx
  FACEBOOK_APP_SECRET: xx
  TWITTER_APP_ID: xx
  TWITTER_APP_SECRET: xx
  KAKAO_CLIENT_ID: xx
  S3_ACCESS_KEY: xx
  S3_SECRET_KEY: xx
  S3_REGION: xx
  S3_BUCKET: xx
  DEFAULT_ADMIN_EMAIL: 최초 관리자 이메일
  DEFAULT_ADMIN_PROVIDER: 최초 관리자의 인증 제공 업체 구별자
  DEFAULT_ADMIN_UID: 인증 제공 업체에 등록된 최초 관리자의 uid
```

## 로컬 개발 환경 구축 방법

기본적인 Rail 개발 환경에 rbenv, pow/powder를 이용합니다.

```
$ rbenv install 2.3.1
$ bundle install
$ bundle exec rake db:migrate
```

### 소스관리 설정

반드시 https://github.com/awslabs/git-secrets를 설치하도록 합니다. 설치 후에 반드시 https://github.com/awslabs/git-secrets#installing-git-secrets 이 부분을 참고하여 로컬 레포지토리에 모두 설정 합니다.

```
$ git secrets --install
$ git secrets --register-aws
```

그리고 데이터베이스는 각 레포지토리마다 다릅니다. 아래 git hook 을 설정합니다

```
$ echo $'#!/bin/sh\nif [ "1" == "$3" ]; then spring stop && powder restart; fi' > .git/hooks/post-checkout
$ chmod +x .git/hooks/post-checkout
```

### 데이터베이스 준비

#### mysql 설정
mysql을 구동해야합니다. mysql의 encoding은 utf8mb4를 사용합니다. mysql은 버전 5.6 이상을 사용합니다.

encoding세팅은 my.cnf에 아래 설정을 넣고 반드시 재구동합니다. 참고로 맥에선 /usr/local/Cellar/mysql/(설치하신 mysql버전 번호)/my.cnf입니다.

```
[mysqld]
innodb_file_format=Barracuda
innodb_large_prefix = ON
```

#### 연결 정보

프로젝트 최상위 폴더에 local_env.yml이라는 파일을 만듭니다. 데이터베이스 연결 정보를 아래와 예시를 보고 적당히 입력합니다.

```
development:
  database:
    username: 사용자이름
    password: 암호
```

#### 스키마

```
CREATE DATABASE parti_union_development_브랜치이름 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

여기서 현재 프로젝트에 연결되는 database의 이름은 config/datbase.yml에서 확인할 수 있습니다. 이 프로젝트는 part_union_development임을 알 수 있습니다. 이후 db 마이그레이션을 수행합니다.
```
bin/rails db:migrate
```
이 작업은 여태까지의 db 변경사항(db/migrate에 기록된)을 db에 모두 적용하는 과정입니다. 이 때, 에러가 날 경우에는 
- 손으로 데이터베이스 스키마를 수정하였을 경우
- 실행 중에 마이그레이션 파일을 수정한 경우
- 마이그레이션이 스키마 마이그레이션 테이블에 업데이트되지 않은 경우
등의 문제의 가능성이 있습니다.

### 로그인 준비

페이스북, 트위터를 연결합니다. 각 키는 프로젝트 최상위 폴더에 .powenv에 등록합니다. 트위터는 사용자 email을 얻어오기 위해 twitter에 따로 요청해야합니다.

```
export FACEBOOK_APP_ID="xx"
export FACEBOOK_APP_SECRET="xx"
export TWITTER_APP_ID="xx"
export TWITTER_APP_SECRET="xx"
```


### 팀원 추가하기

lib/tasks/team.rake에 team의 세부내용을 추가합니다.
app/assets/images에 profile과 동일한 이름의 프로필 이미지 파일을 추가합니다.

아래 명령어를 수행합니다.

```
$ bin/rails team:seed
```


### 굿즈 추가하기

lib/tasks/products.rake에 product의 세부내용을 추가합니다.
app/assets/images/products에 slug과 동일한 이름의 폴더를 생성한 후 그 안에 image파일을 추가합니다. 해당 폴더안에 아래 파일들을 추가합니다.
* primary.png : 굿즈 리스트 화면에 표시될 상품의 이미지입니다.

아래 명령어를 수행합니다.

```
$ bin/rails products:seed
```

### 로컬 서버 켜기

puma-dev https://github.com/puma/puma-dev 를 설치합니다.

```
$ brew install puma/puma/puma-dev
$ puma-dev link -n parti-union
$ sudo puma-dev -setup
$ puma-dev -install -d test
```

아래 명령어로 서버가 켜진 것을 확인할 수 있습니다. 주소는 .dev와의 충돌을 피하기 위해 .test 로 설정합니다.

```
$ ps aux | grep puma-dev
```

서버가 켜져 있다면 브라우저의 주소창에 parti-union.test 를 입력합니다. 메인 페이지를 확인합니다.
