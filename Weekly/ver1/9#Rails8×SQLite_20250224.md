## 目的
<!-- 目的(〜を知りたい/〜を実装したい) -->
月3円で本当にできるのか

## 成果
<!-- 成果(できたこと/できなかったこと) -->
- [x] Docker rails8.0 SPQliteで環境構築
- [x] Dockerのコンテナのディレクトリ構造はローカルと異なる

#### 所要時間
- 240m
#### 使用資料
<!-- 使用資料(教材/書籍/ワークシート/Youtube) -->

## 詳細
<!-- 詳細(キーワード/プロセス//具体例を挙げる/今回の課題解決を今後に繋げられる形で記録) -->
# 環境構築

### リポジトリ作成

`mkdir (ファイル名)`
`cd (ファイル名)`
`touch Dockerfile.dev docker-compose.yml Gemfile Gemfile.lock`

### GitHub リモート接続

- 確認：`git remote -v`
- 接続：`git remote add origin (SSH)`
- 切断：`git remote remove origin`

### コンテナの OS 確認

- コンテナに入る
  `docker exec -it (コンテナ名) bash`
- ベースイメージを確認
  `cat /etc/os-release` #->NAME="Debian GNU/Linux"
  - Ubuntu/Debian -> apt-get を使用
  - CentOS/Red Hat -> yum を使用

### Docekrfile.dev

```
# syntax = docker/dockerfile:1

# RUBY_VERSIONが.ruby-versionとGemfileのバージョンと一致していることを確認
ARG RUBY_VERSION=3.3.5
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim-bookworm

# Railsアプリケーションはここに配置
# 補足：コンテナ内のディレクトリ構造で、rialsだと慣習的にrailsと書くことが多い
WORKDIR /rails

# gemのビルドに必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git curl sqlite3

# bundle installを実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# デフォルトでサーバーを起動、実行時に上書き可能
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
```

### Gemfile

```
source 'https://rubygems.org'
gem 'rails', '~> 8.0'
```

### docker-compose.yml

```
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.dev
    command: bash -c "rm -f tmp/pids/server.pid && bin/rails server -b 0.0.0.0"
    tty: true
    volumes:
      - .:/rails
      - /rails/tmp
      - /rails/log
      - bundle:/usr/local/bundle
    ports:
      - "3001:3000"
    environment:
      - RAILS_ENV=development

volumes:
  bundle:
```

### Rails スケルトンアプリを作成

- 先に Rails アプリ作成し、それに基づきイメージを再ビルドする
  `docker compose run --no-deps web rails new . --name=Raku-Nippo  --force`
  `docker compose build`

### Dockerfile.dev へ ENTRYPOINT を追加

`ENTRYPOINT ["./bin/docker-entrypoint"]`
`docker compose build`
`docker compose up`

## 考察
<!-- 考察(今後の展望/) -->
とりあえずここまで！あとはGoogleと繋いで月3円でできるか試したい！