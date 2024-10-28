### 今回の成果

#### 作業時間：　 60m

#### 使用資料

- [GitHub: External](https://github.com/Sorcery/sorcery?tab=readme-ov-file#external)
- [GitHub: UserActivation のメソッド内容](https://github.com/Sorcery/sorcery/blob/master/lib/sorcery/controller/submodules/activity_logging.rb)

#### 成果

<!--現状から持ってきて、ToDo更新して考察-->

login_at のエラーは UserActivation が原因の可能性

### ゴール

sorcery ＋ LINE ログインを復旧

### 環境

|| 技術 | バージョン |
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

- [] sorsery が動いていない
- [x] LINE は接続はされている

### 試行内容

<!--仮説→調査→検証→結果と考察-->

1. 《仮説》UserSession/Oauth Controller の書き分け、内容の見直し

- 《調査》
  - 【現状】login_at のエラーで、NilClass
  - 【内容】[何のメソッドか調べる](https://github.com/Sorcery/sorcery?tab=readme-ov-file#external)と External
  - 【方法 1】`config.user_class = "User"`を sorcery 設定に入れる
  - 【方法 2】oauth#callback に`@user.activate! if defined?(Sorcery::Controller::Submodules::UserActivation)`を入れる
- 《検証》
  - 【未実行】1.そもそも sorcery はデフォルトで User が設定されているのに必要か？
  - 【未実行】2.UserActivation は入っている？
- 《結果と考察》
  - UserActivation のサブモジュールを入れているなら記述すべきコードが足りない様子
