## ゴール
LIFFログインを復活させる
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] JSとturboの競合がわからず、一旦JSをコメントアウト
- [x] LIFFログインのコメントアウト解除
- [] LINEのリッチメニューからLIFFでログイン

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
#### 作業時間：　30m
#### 使用資料
- []()
- []()

### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》競合はturboの設定をapplication.htmlでいじってから起こっていた？
  - 《調査》
  - 《検証》競合して動かなかったsorceryとLINEログインが動いたので、LIFFも動かしてみる
    - コメントアウト解除
    - 通常ログインにエラーが起きないことを確認
  - 《結果と考察》
    - リッチメニューにはLIFFへのURLが置いてあるので、JSでLIFF URLを開いたらログインできるようにすれば良さそう。昨日やったJSの学びからもうちょいで理解できそうなのでちょっと保留！