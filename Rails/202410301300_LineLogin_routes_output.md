## 目的

<!-- 目的(〜を知りたい/〜を実装したい) -->

ルーティング復習

- 何回か Railsgaid に来ているんだけどな...

## 成果

<!-- 成果(できたこと/できなかったこと) -->

- [x] RESTful なルーティング
- [x] 動的なセグメント、静的なセグメント
- [x] ルーティングのテスト

#### 所要時間

- 120m

#### 使用資料

<!-- 使用資料(教材/書籍/ワークシート/Youtube) -->

- [rails gaid](https://railsguides.jp/routing.html#rails%E3%83%AB%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E7%9B%AE%E7%9A%84)
- [Rails Routing](https://railsguides.jp/routing.html#%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0%E3%81%AE%E8%AA%BF%E6%9F%BB%E3%81%A8%E3%83%86%E3%82%B9%E3%83%88)

## 詳細

<!-- 詳細(キーワード/プロセス//具体例を挙げる/今回の課題解決を今後に繋げられる形で記録) -->

- RESTful なルーティング（index、show、new、create、edit、update、destroy）
  - 基本的な考え方: リソースごとの URI に適切な HTTP メソッドを使うことで、『リソース』を操作
  - RESTful:Representational State Transfer
  - 一貫したルーティング構造を作るため、構造理解がしやすい
- シンプルなルーティング（リソースフルではない）
  - 文字列を固定しない動的なセグメント`users/:id`
  - 固定文字列を指定した静的なセグメント`users/profile`
- ルーティングのテスト
  - `rails routes`でルーティングを確認

## 考察

<!-- 考察(今後の展望/) -->

- そもそも：が動的セグメントという知識が曖昧だった
- そもそも```gem:Omniauth-line``` のコールバックパスが`oauth/callback`とGitHubで確認してなかった
  - lineは、oauth/callbackにリダイレクトしてくるためドキュメントでは下記のようにしている
    ```ruby
    post 'oauth/callback', to: 'oauths#callback'
    get 'oauth/callback', to: 'oauths#callback'
    ```
    - [Omniauth-line: Github](https://github.com/kazasiki/omniauth-line/blob/master/lib/omniauth/strategies/line.rb)で OmniAuth がコールバックパスを`oauth/callback`としていることを確認
    ```ruby
    def callback_url
      # Fixes regression in omniauth-oauth2 v1.4.0 by https://github.com/intridea/omniauth-oauth2/commit/85fdbe117c2a4400d001a6368cc359d88f40abc7
      options[:callback_url] || (full_host + script_name + callback_path)
    end
    ```
    - `:callback_url`が明示的に指定されている場合はそのままURLとし、されていない場合、`full_host + script_name + callback_path`がコールバック URL として使用される
- そもそもルーティングの実行順番は、原則より具体的なルートを先に、一般的なルートを後に。
【具体例】
```ruby
# 具体的なパス
get 'photos/latest', to: 'photos#latest'
# 一般的なリソース群
resources :photos
```
  - 今回だと、動的なセグメント(3行目)は、具体的にcallbackとしている静的なセグメント(1,2行目)を先に実行する
  ```ruby
    post 'oauth/callback', to: 'oauths#callback'
    get 'oauth/callback', to: 'oauths#callback'
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  ```
  - 実際の動きとしては、
    - 1.LINEログインボタンを押したら```get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider```がviewからリクエストされ、oauth/lineとしてoauths#oauthアクションが実行される
    - 2.リダイレクト先には```get 'oauth/callback', to: 'oauths#callback'```が指定されているため、ログイン後にoauth/callbackにリダイレクトされる
    - 3.oauth/callbackにリダイレクトされた際に```post 'oauth/callback', to: 'oauths#callback'```が実行され、ログインされる
