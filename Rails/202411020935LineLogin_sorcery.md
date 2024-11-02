## ゴール
sorceryを動かす！
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] LINEログインはできるところまで修正
- [] sorceryを動かす
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
- [x] sorceryを動かす
#### 作業時間：　60m
#### 使用資料
- [Sorceryのドキュメント](https://github.com/Sorcery/sorcery/wiki/Simple-Password-Authentication)

### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》sorceryが動かないためuser_classのエラーが出ている
  - 《調査》エラー読む
  ```ruby
  [DOM] Input elements should have autocomplete attributes (suggested: "new-password"): (More info: https://goo.gl/9p2vKq) <input class=​"grow" placeholder=​"password" type=​"password" name=​"user[password]​" id=​"user_password">​
  sign_up:1 [DOM] Input elements should have autocomplete attributes (suggested: "new-password"): (More info: https://goo.gl/9p2vKq) <input class=​"grow" placeholder=​"password" type=​"password" name=​"user[password_confirmation]​" id=​"user_password_confirmation">​
  ```
  ```ruby
  TypeError: map.get is not a function
  ```
    - Oauth実装時はturboを切っておいたほうがJSとOauthの競合が起こりにくいのかな...
  - 《検証》一旦、rails newした時の設定に戻してみる
  ```ruby
  <!DOCTYPE html>
<html>
  <head>
    <title>Shibatt</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    - <%= stylesheet_link_tag "application", media: "all" %>
    + <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_include_tag "application", "data-turbo-track": "reload" %>

    <!-- ... 他のコード ... -->
  </head>
  - <body class="font-sans" data-turbo-suppress-warning data-user-id="<%= current_user&.id %>">
  + <body class="font-sans" data-turbo="false" data-user-id="<%= current_user&.id %>">
    <!-- ... 他のコード ... -->
  </body>
  </html>
  ```
  - 《結果と考察》
    - sorceryが動くようになった
    - Oauthの時はturboを切っておくといいかももう少し深く調査必要
      - そもそも、今回は切ったわけではないと思うし。
