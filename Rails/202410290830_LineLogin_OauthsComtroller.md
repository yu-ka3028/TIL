## ゴール

callback を正しく返す

## 現状

<!--タスク分解（何ができて、何ができてないかを可視化）-->

- [] なぜか callback に line が入り、provider が nil になっている

### 環境

| 技術                | バージョン                                   |
|-------------------------------------------- | --- |
| Ruby                | 3.2.3                                        |
| Rails               | 7.1.3.4                                      |
| JavaScript          |                                              |
| TailwindCSS/DaisyUI |                                              |
| Heroku/Mysql,JawsDB |                                              |
| Docker/Git/GitHub   |                                              |
| 認証                | Sorcery                                      |     |
| API                 | LINE ログイン,LINE Messaging API, OpenAI API |

## 成果

<!--現状から持ってきて、ToDo更新して考察-->
一進一退の攻防・・・。でもコールバックURLは問題なさそう！
#### 作業時間： １２０m

#### 使用資料

- [sorcery/External: GitHub](https://github.com/Sorcery/sorcery/wiki/External)

### 試行内容

<!--仮説→調査→検証→結果と考察-->

1. 《仮説》ドキュメント通りで oauth アクションが呼ばれないのでルーティングの順番を変えてみる

- 《調査》なし（ルーティングの順番変えるだけ）
- 《検証》
  - 【views】
  ```ruby
  <%= link_to auth_at_provider_path(provider: :line) do %>
  ```
  - 【変更前 routes】
  ```ruby
  post 'oauth/:callback', to: 'oauths#callback'
  get 'oauth/:callback', to: 'oauths#callback'
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  ```
  - 【ログ】
  ```ruby
  Started GET "/oauth/line" for 192.168.65.1 at 2024-10-29 11:08:44 +0900
  web-1  | 11:08:44 web.1  | Cannot render console from 192.168.65.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
  web-1  | 11:08:44 web.1  | Processing by OauthsController#callback as HTML
  web-1  | 11:08:44 web.1  |   Parameters: {"callback"=>"line"}
  ```
  - oauth アクションを読んでいるのに、`OauthsController#callback`callback でいいの？ここのアクション

  - 【変更後 routes】
  ```ruby
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  get 'oauth/:callback', to: 'oauths#callback'
  post 'oauth/:callback', to: 'oauths#callback'
  ```
  - 先に oauth のルーティングを持ってきてみた（公式に逆らってるけど...）
    - 【ログ】
    ```ruby
    Started GET "/oauth/line" for 192.168.65.1 at 2024-10-29 11:13:00 +0900
    web-1  | 11:13:00 web.1  | Cannot render console from 192.168.65.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
    web-1  | 11:13:00 web.1  | Processing by OauthsController#oauth as HTML
    web-1  | 11:13:00 web.1  |   Parameters: {"provider"=>"line"}
    ```
    - provider が line になり、次へ進めるようにはなった[![Image from Gyazo](https://i.gyazo.com/caaea1681825d374ce9eb901016d254e.png)](https://gyazo.com/caaea1681825d374ce9eb901016d254e)
    - つまりコールバックURLの設定は壊れていない！
    - が、その後で今度はcallbackアクションであってほしい部分がoauthになってしまう
    ```ruby
    Started GET "/oauth/callback?provider=line&code=..." for 192.168.65.1 at 2024-10-29 11:13:02 +0900
    web-1  | 11:13:02 web.1  | Cannot render console from 192.168.65.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
    web-1  | 11:13:02 web.1  | Processing by OauthsController#oauth as HTML
    web-1  | 11:13:02 web.1  |   Parameters: {"provider"=>"callback", "code"=>"123abc", "state"=>"abc1234"}
    ```
- 《結果と考察》
  - やっぱドキュメント通りで動かせる道を探したほうがいいってことだよな・・・
  - 前どうやってたんだろ・・・自分のコード探しに行ってみよ。    

