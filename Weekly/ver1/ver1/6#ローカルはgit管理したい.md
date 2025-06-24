## 目的

<!-- 目的(〜を知りたい/〜を実装したい) -->

ローカルは手動、リモートは Win SCP でファイル混在したので git 導入検討してみた

## 成果

<!-- 成果(できたこと/できなかったこと) -->

```
Project_20250127_ClientName/
├── demo/            # 最新ファイルを配置
├── bk/              # 触る前のバックアップファイルを配置
├── Readme.md        # 作業メモ・目次・Wiki的情報

```

- [ ] デフォルトブランチを master→main にする
- ローカルは git 管理する

  - [ ] リモート(WinSCP)からファイルを持ってくる：手動
  - [ ] (はじめて触るファイルの場合)bk へコピー
  - [ ] ファイル名の後ろへ\_yyyydddd をつけて複製 → リモートへあげる(手元には不要)
  - [ ] demo ディレクトリに移動させて git 管理

- [ ] git コマンド集作成
- [ ] シェルスクリプトで自動化

#### 所要時間

- 120m

#### 使用資料

<!-- 使用資料(教材/書籍/ワークシート/Youtube) -->

## 詳細

<!-- 詳細(キーワード/プロセス//具体例を挙げる/今回の課題解決を今後に繋げられる形で記録) -->

### デフォルトブランチを master→main にする

```log
i.yu-ka@ishiiyuukounoMacBook-Air logs % git log origin/main
commit 355c76abe43e4bf260dd37a653d90bd7e6233031 (origin/main)
Author: 石井悠香 <i.yu-ka@ishiiyuukounoMacBook-Air.local>
Date:   Thu Jan 23 22:15:42 2025 +0900
    first commit
i.yu-ka@ishiiyuukounoMacBook-Air logs % git log
commit 53f2d772d46aa51f60cf91d72a0c25ef7904f4f6 (HEAD -> main, origin/master, origin/HEAD)
Author: 石井悠香 <i.yu-ka@ishiiyuukounoMacBook-Air.local>
Date:   Sat Feb 1 15:35:18 2025 +0900
    log_path
```

現状：リモートの main に最初のコミット、master に今回のコミットがある。ローカルは master ブランチのみ

1.ローカルのブランチ名を `main` に変更
`git branch -M main`

2.リモートの master ブランチの内容をローカルの main ブランチにリセット
`git reset --hard origin/master`

3.リモートに mian ブランチを push
`git push origin main`

その他使ったコマンド
`git branch -r` リモートのブランチ確認
`git pull origin main`でもいいが、丁寧にやると下記

`git fetch origin/main` リモートの mian ブランチの情報をローカルの今のブランチにダウンロード
`git log origin/main` マージするリモートの main ブランチの log を見て、ローカルにマージしたい対象が合っているか確認
`git merge origin/main` リモートの main ブランチの内容をローカルの main ブランチにマージ

## 考察

<!-- 考察(今後の展望/) -->

まとめきれなかったけど、もう少し調べてる内容あるので来週に持ち越し！
