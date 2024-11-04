## ゴール
callbackが動くようになること
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] routesがうまくいかない/oauthとcallbackが片方のみしか動かない
### 環境
| 技術 | バージョン |　
| -- | -- |
| Ruby | 3.2.3 |
| Rails | 7.1.3.4 |  　
| JavaScript | |
| TailwindCSS/DaisyUI | |
| Heroku/Mysql,JawsDB | |
| Docker/Git/GitHub | |
| 認証 | Sorcery | |
| API | LINEログイン,LINE Messaging API, OpenAI API |

## 成果
<!--現状から持ってきて、ToDo更新して考察-->
ルーティング動くようになりました！
#### 作業時間：　30m
#### 使用資料
- [GitHub/sorcery](https://github.com/Sorcery/sorcery/blob/master/docs/README.md)
- [rails gaid](https://railsguides.jp/routing.html#rails%E3%83%AB%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E7%9B%AE%E7%9A%84)

### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》LINEは```get "oauth/callback" => "oauths#callback" # for use with Github, Facebook```が不要？
  - 《調査》GitHub/sorceryドキュメントにコメントアウトで記載あり
  ```
  # config/routes.rb
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  ```
  - 《検証》コメントアウトしてみる
  ```ruby
    post 'oauth/callback', to: 'oauths#callback'
  - get 'oauth/callback', to: 'oauths#callback'
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  ```
  - 《結果と考察》失敗：providerがcallbackになっているので、LINEでも必要そう
  ```ruby
  <ActionController::Parameters {"provider"=>"callback", "code"=>"abc123", "state"=>"1234abc", "controller"=>"oauths", "action"=>"oauth"} permitted: false>
  ```
2. 《仮説》：がついているから
  - 《調査》[rails gaid](https://railsguides.jp/routing.html#rails%E3%83%AB%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E7%9B%AE%E7%9A%84)
  - 《検証》:を外す
  ```ruby
    post 'oauth/callback', to: 'oauths#callback'
   get 'oauth/callback', to: 'oauths#callback'
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  ```
  - 《結果と考察》成功
    - ：をなんとなく書くもの〜くらいにしか思ってなくて気づかなかった
    - [ルーティング復習](https://github.com/yu-ka3028/TIL/blob/main/Rails/202410301300_LineLogin_routes_output.md)
