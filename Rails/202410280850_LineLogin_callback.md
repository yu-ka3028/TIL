  ## ゴール
一旦、ログアウトは置いておいてログインできるようにする
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] Rails側（turboの書き方、sorceryの書き方、aouthの書き方）は問題なさそう
- [x] ログアウトはJSの干渉の可能性が高そう
- [ ] 一旦ログインできるようにする（今週中）
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
細々エラーは解決してきたが、callbackがまだうまくいっていない<br>
デバッグ結果providerにlineが入らず、callbackに入っている？？
```ruby
callback/provider
nil
```
#### 作業時間：　90m
#### 使用資料
- [login_at/login_from: GitHub](https://github.com/NoamB/sorcery/blob/4aaf38363eddf7a2982312ce68f0105dcc4ae8dc/lib/sorcery/controller/submodules/external.rb#L111)
- [params?oauth_params?書き方: 記事](https://qiita.com/okada84108983/items/0c84c01b88072c004873)
- [callback書き方:GitHub](https://github.com/Sorcery/sorcery/wiki/External)
### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》callbackができてない、lineと繋がっていない
  - 《調査》ログ確認
  ```ruby
  Parameters: {"provider"=>"callback", "code"=>"abc1234", "state"=>"1234abc"}
  NoMethodError (undefined method `original_callback_url' for nil:NilClass):
  ```
  - providerがcallback？ルーティング間違えてるかな？
  - 《検証》ルーティング編だったので修正
    ```ruby
    get 'oauth/:callback', to: 'oauths#callback', as: 'auth_at_provider'
    get 'oauth/:callback', to: 'oauths#callback', as: 'oauth_callback'
    ```
  - 《結果と考察》login_atのエラーは解消
2. 《仮説》TOPページもLINEへつながらず、ルーティングがまだダメっぽい
  - 《調査》ログ確認
    ```ruby
    ActionView::Template::Error (No route matches {:action=>"callback", :controller=>"oauths", :provider=>:line}, missing required keys: [:callback]):
    ```
    - ルーティングがまだダメっぽい
  - 《検証》
    【sorcery/External：公式ドキュメントのルーティング】
    ```ruby
    # config/routes.rb
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    ```
    【自分の修正】
    ```ruby
      post 'oauth/:callback', to: 'oauths#callback'
      get 'oauth/:callback', to: 'oauths#callback'
    + get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    ```
    - 追記分のコードは、特定のプロバイダーに対してOAuth認証を開始するためのエンドポイントを定義
  - 《結果と考察》TOPページは表示OK
3. 《仮説》callbackがうまくいかない、provider=>lineはわかるけどcallback=>lineってなんだ？ルーティング違うか？
    - paramsでなく、oauth_paramsにしたらいい？
  - 《調査》ログ確認
    ```ruby
    Processing by OauthsController#callback as HTML
    web-1  | 10:32:20 web.1  |   Parameters: {"callback"=>"line"}
    web-1  | 10:32:20 web.1  | Unpermitted parameter: :callback. Context: { controller: OauthsController, action: callback, request: #<ActionDispatch::Request:0x0000ffff6a89be20>, params: {"controller"=>"oauths", "action"=>"callback", "callback"=>"line"} }
    web-1  | 10:32:20 web.1  | callback/provider
    web-1  | 10:32:20 web.1  | nil
    web-1  | 10:32:20 web.1  | Completed 500 Internal Server Error in 2ms (ActiveRecord: 0.0ms | Allocations: 883)
    web-1  | 10:32:20 web.1  | 
    web-1  | 10:32:20 web.1  | 
    web-1  | 10:32:20 web.1  |   
    web-1  | 10:32:20 web.1  | NoMethodError (undefined method `to_sym' for nil:NilClass):
    web-1  | 10:32:20 web.1  |   
    web-1  | 10:32:20 web.1  | app/controllers/oauths_controller.rb:14:in `callback'
    ```
    - oauth_paramsにするのはRails4？の時の書き方みたいなのでparamsで問題ない
  - 《検証》次回へ〜