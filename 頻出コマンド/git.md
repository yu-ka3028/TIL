# GitHubリモート接続
- 確認
`git remote -v`
- 接続
`git remote add origin (SSH)`
- 切断
`git remote remove origin`

# マージされてないプルリクを確認
- リモートからgit cloneする:初期のみ
`git clone (SSH)`

- 最新のリモート状態をローカルへ取り込む
`git fetch origin pull/(No.)/head:pr-(No.)`
  - プルリクNoを指定してローカルで確認できる -> 編集するなら参照を参考にブランチ切り替えて編集、push。
  - 新しいブランチも作成される
    [参照](https://docs.github.com/ja/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/check
  
  - Dockerを使用している場合
  `docker compose build`
  `docker compose up`
