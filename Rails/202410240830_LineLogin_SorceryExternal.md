### 今回の成果
#### 作業時間：　90m
#### 使用資料
- [emailのデフォルトをusernameにする：記事](https://note.com/ssksyk_beer/n/n895d2582093b)
- [Sorcery: GitHub](https://github.com/Sorcery/sorcery/wiki/External)
#### 成果
<!--現状から持ってきて、ToDo更新して考察-->
- [Sorcery: GitHub](https://github.com/Sorcery/sorcery/wiki/Simple-Password-Authentication)でそもそもSorceryの設定見直し
### ゴール
sorcery ex
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
- sorceryログイン/新規登録/ログアウトができない
### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》emailなしにする設定時にドキュメントから離れて迷子
  - 《調査》sorceryのドキュメントで導入からチェック
  - 《検証》
    - emailがデフォルトになっていないか再確認
    - External部分はドキュメントに沿って一部修正（大幅修正はない）
  - 《結果と考察》
    - sorceryはemailがデフォルトでカラムにありfalseになっているので、gemインストール時のコメントアウトを外してusernameに変えれていることを確認
    - LINEへの接続までは再確認
    - ログアウト、sorceryでのログインは依然としてできず

