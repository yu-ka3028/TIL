### 今回の成果
#### 作業時間：　60m
#### 使用資料
- [@hotwired/turbo-rails](https://www.airteams.net/media/articles/1830)
#### 成果
<!--現状から持ってきて、ToDo更新して考察-->
- turboの干渉が今更ではなく、シンプルにsorceryの設定ができていないと思うのでそこから見直し！
### ゴール
ログアウトボタンを復活させたい
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

### 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- sorceryの機能もダウンしている
- MessagingAPIは動いているんだよな・・・
### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》ターボが干渉している？
  - 《調査》@hotwired/turbo-railsの書き方確認
  - 《検証》ターボを切ってみたらGETメソッドで返ってくる(だよね...)
  - 《結果と考察》ターボは関係なさそう（アプデも見つからないし）→sorceryかな！

