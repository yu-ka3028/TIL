## ゴール
本番でログインできるようにする
## 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [x] テスト環境のログイン
- [ ] 本番環境のログイン
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
- [ ] 本番環境のログイン(新規登録のみOK)
#### 作業時間：　80m
#### 使用資料

### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》DBに保存されていない、DBのカラムがテストと本番で一致していない可能性がある
  - 《調査》
  - テスト環境のログ
  ```ruby
  [1] pry(main)> User.find_by(username:"ゆーか") 
  User Load (1.6ms)  SELECT `users`.* FROM `users` WHERE `users`.`username` = 'ゆーか' LIMIT 1
  => #<User:0x0000ffff85975128
   id: 36,
   username: "ゆーか",
   crypted_password: nil,
   salt: nil,
   created_at: Sat, 02 Nov 2024 21:54:13.396937000 JST +09:00,
   updated_at: Sat, 02 Nov 2024 21:54:13.447004000 JST +09:00,
   profile_image_url: nil,
   email: nil,
   provider: "line",
   uid: "123abc">
   ```
   - 本番環境のログ
   ```ruby
  [1] pry(main)> User.find_by(username: "ゆーか")
  User Load (1.6ms)  SELECT `users`.* FROM `users` WHERE `users`.`username` = 'ゆーか' LIMIT 1
  => #<User:1234a
   id: 36,
   username: "ゆーか",
   crypted_password: nil,
   salt: nil,
   created_at: Sat, 02 Nov 2024 22:39:36.279579000 JST +09:00,
   updated_at: Sat, 02 Nov 2024 22:39:36.297823000 JST +09:00,
   line_user_id: nil,
   profile_image_url: nil,
   email: nil,
   provider: "line",
   uid: "123abc">
  ```
  - 本番はline_user_idが残りっぱなし

  - 《検証》herokuのマイグレーションは全てUpしているので、再度line_user_idのカラム削除のマイグレーションを実行
  - 《結果と考察》line_user_idのカラムが削除されたが、エラーは続いている