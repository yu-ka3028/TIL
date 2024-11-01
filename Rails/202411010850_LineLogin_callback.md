## ゴール
callbackが返るようにしたい
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] ドキュメント見直しで、model,controller,routes,migrationファイルの修正

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
#### 作業時間：　20m
#### 使用資料
- [ソースコード確認login_from: GitHub/Sorcery_External](https://github.com/NoamB/sorcery/blob/master/lib/sorcery/controller/submodules/external.rb#L111)

### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》configのsorceryでUserが設定できていない
  - 《調査》Sorceryのドキュメントに記載されている内容に、config.user_class = 'User'を追加
  【エラー文】
  ```ruby
   ArgumentError (You have incorrectly defined user_class or have forgotten to define it in the initializer file (config.user_class = 'User').):
  ```
  - 《検証》エラー文の指示通り追加
  ```ruby
  Rails.application.config.sorcery.submodules = [:external]
  Rails.application.config.sorcery.configure do |config|
  + config.user_class = 'User'

  config.external_providers = [:line]
  config.line.key = Rails.application.credentials.dig(:line, :channel_id)
  config.line.secret = Rails.application.credentials.dig(:line, :channel_secret) 
  config.line.callback_url = Rails.application.credentials.dig(Rails.env, :line, :callback_url)
  config.line.scope = 'profile'
  config.line.user_info_mapping = { username: 'displayName', uid: 'userId'}

  config.user_config do |user|
    user.authentications_class = Authentication
    # デフォルトであるemailを使わず、usernameを使用
    user.username_attribute_names = [:username]
  end
end  
```
  - 《結果と考察》そもそも・・・config.user_classのエラーってsorceryの基本的な機能がエラーだから出ているのでは・・・？
