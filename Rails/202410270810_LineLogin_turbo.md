### 今回の成果
#### 作業時間：　60m
#### 使用資料
- みんなのGitHub
#### 成果
<!--現状から持ってきて、ToDo更新して考察-->
turboの書き方は間違ってなさそうなので、JSとの干渉が原因か・・・？
### ゴール
UserActivationが原因か試す
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
| API | LINEログイン,LINE Messaging API, OpenAI API | |

### 現状
<!--タスク分解（何ができて、何ができてないかを可視化）-->
- [] turboをviewの記載でオフにするとGETメソッドが返る
- [] UserActivationは、使っていないはずなのに出てくる
### 試行内容
<!--仮説→調査→検証→結果と考察-->
1. 《仮説》UserActivationはわからんが、usj周りの設定がうまくいていない
  - 《調査》buildするときのログみる
    ```ruby
     $ esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets --watch
    web-1  | 08:12:42 css.1  | $ tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify --watch
    web-1  | 08:12:42 js.1   | ✘ [ERROR] Could not resolve "@rails/ujs"
    web-1  | 08:12:42 js.1   | 
    web-1  | 08:12:42 js.1   |     app/javascript/application.js:4:18:
    web-1  | 08:12:42 js.1   |       4 │ import Rails from "@rails/ujs"
    web-1  | 08:12:42 js.1   |         ╵                   ~~~~~~~~~~~~
    web-1  | 08:12:42 js.1   | 
    web-1  | 08:12:42 js.1   |   You can mark the path "@rails/ujs" as external to exclude it from the bundle, which will remove this error and leave the unresolved path in the bundle.
    web-1  | 08:12:42 js.1   | 
    web-1  | 08:12:42 js.1   | 1 error
    web-1  | 08:12:42 js.1   | [watch] build finished, watching for changes...
    web-1  | 08:12:43 css.1  | 
    web-1  | 08:12:43 css.1  | Rebuilding...
    web-1  | 08:12:43 web.1  | DEBUGGER: Debugger can attach via UNIX domain socket (/tmp/rdbg-0/rdbg-36)

    ```
    - Rails7ではimportmapが推奨されており、rails/ujsは非推奨でturboを使うのが一般的
  - 《検証》app/javascript/application.jsでどっちをつかてるか確認
    ```ruby
    // Entry point for the build script in your package.json 
    import "@hotwired/turbo-rails" 
    import "./controllers" 
    import Rails from "@rails/ujs"
    Rails.start()
    ```
    - UserActivation周り検証した時に書いた記憶あります...消してなかったか

  - 《結果と考察》
    - Rails7ではturboが推奨、ujsも使おうとすると競合するため片方にした方がいい
