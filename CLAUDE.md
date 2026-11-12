# CLAUDE.md

**kanji-db-data** リポジトリで作業するときに Claude Code が参照するファイルです。
kanji-db.com が漢字のオープンデータを突き合わせて作ったデータセット(似ている漢字・音符・同音異義語など)の公開リポジトリ

**このファイルは毎回読む最小の入口**です。実態とズレたら直すが、何でも追記しない。
ここに置くのは「次のセッションが最初の5分で知らないと事故る」こと、絶対条件、索引だけ。

**短く保つこと。** 目安は **200行以内**。
恒久的な知見・調査記録・事故の顛末は `docs/` に置き、ここから短く参照する。
横断的なGit/AI運用は `uball/cost/docs/multi-agent-development.md` を正本とし、全文コピーしない。

## 基本方針(uball からの指示。全リポジトリ共通)

1. **可能な限り日本語で返答する。** 直訳調にならないよう、書いたら読み返す。
2. **修正したものは、断りが無い限り `main` へ直接 push する。** PR は不要。
3. **なるべく AI が自動で作業を進められる状態を用意する。** 手作業を都度 uball に
   頼むのではなく、自動化・自己完結を優先する。APIキー・権限が要るときは、
   何が足りないかを具体的に伝えて依頼する。
4. **作業開始時と書き込み直前に `main` のremote HEADを確認する。** uball本人や
   別セッションが並行更新する前提で、進んでいたら最新状態へ載せ直して再検証する。
   **force pushしない。他セッションの変更を勝手に消さない。**
5. **setup 系のスクリプトは冪等に書く。** 何度実行しても同じ結果になるようにする。
6. **画面に出る日本語は自然で分かりやすく。** 内部用語(データ・レコード・トークン等)を
   画面に出さない。
7. **画面を作るときは余白を丁寧に設計する。** 詰まった画面は読みにくく、粗く見える。
8. **本番へ出す前に、開発用の設定が残っていないか確かめる。**
9. **生成物に `localhost` 等が混ざっていないかを機械的に検証してからデプロイする。**
   目視で済ませない(`grep -c localhost dist/assets/*.js` が 0 であること)。
10. **問題は場当たり的な回避で済ませず、原因を突き止めて直す。** ただし範囲が
    大きくなりすぎるときは必要最小限にとどめ、残りは課題として書き残す。
11. **つまずいたら、その場で書き残す。** うまくいった話よりつまずいた話に価値がある。
    「何が起きたか」だけでなく「なぜそうなったか」「次はどう避けるか」まで。
    **置き場所は `docs/KNOWHOW.md`**(CLAUDE.md ではない)。

## 横断の知見は cost を正本にする(写さない)

同じ土台(Cloudflare Workers + D1 + R2 + Pages)で作っている他のリポジトリと
**踏む穴は同じ**。横断で効く知見は
[uball/cost の docs/playbook/](https://github.com/uball/cost/tree/main/docs/playbook) に
集約してある。複数AI・複数セッションの競合回避は
[docs/multi-agent-development.md](https://github.com/uball/cost/blob/main/docs/multi-agent-development.md)
を正本とする。**新しく調べる前にまずそこを見る。**

- `credentials.md` … 共通認証の正本と既存repoを壊さない移行順序
- `d1.md` … D1 の課金・行数・実行計画の落とし穴
- `cache-and-r2.md` … キャッシュと R2(負キャッシュ・署名・容量)
- `crawlers.md` … クローラーと WAF
- `workers.md` / `frontend.md` / `auth.md` / `workflow.md` / `verify.md`

**画面を作るなら、先に
[docs/web-standards.md](https://github.com/uball/cost/blob/main/docs/web-standards.md) を読む。**
**あれは知見ではなく要件**で、**満たさないと完了にならない**
(URLへの状態の同期・状態ごとのコントラスト・D1の量・スクロールバーの領域・
内容幅とタブ位置・ダブルタップ拡大の停止)。**全項目に受け入れ条件が付いている。**

**画像が要るときは `uball/imgapi`**(自前のGPUで作る。**既定の経路は1枚 $0**)。
`add_repo uball/imgapi && cd ../imgapi && node cli/imgen.mjs models`。
**アイコン・図解・OGPは手書きSVGのほうが良い** —— 判断は
[playbook/frontend.md](https://github.com/uball/cost/blob/main/docs/playbook/frontend.md) 0章、
使い方は [imgapi の docs/PORTING.md](https://github.com/uball/imgapi/blob/main/docs/PORTING.md)。

**このリポジトリで見つけた知見は、まずここ(`docs/`)に書く。**
横断で効くものは cost 側の巡回が吸い上げる(こちらから playbook を直接は直さない)。

## cost からの指示(`from-cost` ラベルの Issue)

`uball/cost` が全リポジトリを横断して使用量・費用・異常を見ている。
**作業を始めるとき、`from-cost` ラベルの open Issue があれば先に読む。**
数字と直し方の見立てが添えてあるので、調査をやり直さなくてよい。
直したら**その Issue に数字で結果を返す**(cost 側が確認して閉じる)。

## ucon(状況の一覧と人間判断)

uball は [ucon](https://ucon.uuu3.workers.dev) でこのrepoのCI・commit・作業状況を横断で見ている([見方](https://github.com/uball/cost/blob/main/docs/ucon-guide.md))。
**人間にしか決められないことはIssueや会話に散らさず ucon の判断へ出す**(条件は cost `docs/ucon-protocol.md`)。回答待ちでも範囲外の作業は止めない。
commitには `auto:` か `Co-Authored-By:` を付ける。署名が無いとAIの作業が「人」に数えられる。

## プロジェクト概要

[kanji-db.com](https://kanji-db.com)(本体は `uball/kanji`)が配っている、自前で突き合わせて作ったデータの**公開リポジトリ**。
目的は**外部からの参照(被リンク)を作ること** — 2026-11-11 時点で Bing の被リンクは0だった
(`uball/kanji` の `docs/MARKET-STRATEGY-2026-11.md`・`docs/OUTREACH.md`)。

- `data/` … 似ている漢字・音符・同訓異義・同音異義語・対義語・収録外の字の案内(TSV)と `datapackage.json`
- `kits/` … Anki デッキ・IME 辞書2本
- **中身は kanji-db.com の `/data` と常に同じファイル。ここで手で直さないこと**(直すのは `uball/kanji` の書き出しスクリプト)。
- ライセンスは CC BY-SA 4.0(`LICENSE`)。出典ごとの帰属表示は `ATTRIBUTION.md`。
  **サイトへのリンクは「お願い」で、条件として書かないこと**(条件を足すとライセンス違反になる)。


## デプロイ済み環境

なし(公開リポジトリそのものが配布物。2026-11-12 に cost の `new-repo.yml` で作成、公開)。


## 認証情報の在り処

Cloudflare の共通 `for_ai` token の**正本は `uball/cost/.env`**。
Cloudflare を触る必要が生じた時点で cost が無ければ `add_repo uball/cost` し、次で読む。

```bash
export CLOUDFLARE_API_TOKEN=$(grep '^CLOUDFLARE_API_TOKEN=' ../cost/.env | cut -d= -f2-)
```

既存repoの `../mybox/.env` 参照は互換用として残っているので、それだけを直すための一斉変更はしない。
ただし認証処理やdeploy周辺を次に触るときは、`cost/.env` 優先へ自然に寄せる。
詳細は `uball/cost/docs/playbook/credentials.md`。


## 開発とデプロイの手順

`uball/kanji` でデータを書き出し直したら(`scripts/export-open-data.mjs` / `export-study-kits.mjs`)、ここへ写す:

```bash
bash scripts/sync-from-kanji.sh ../kanji   # 冪等。kanji 側 index.json の sha256 と突き合わせ、食い違えば止まる
```

件数が変わったら `README.md` の表(英日2か所)も直す。


## リポジトリ固有の知見

**詳細は [docs/KNOWHOW.md](docs/KNOWHOW.md)。**
CLAUDE.mdには「知らないと直ちに事故る」ものだけを数行で残す。
一般化できる知見はcostへ昇格し、ここへ重複コピーし続けない。

## Git のブランチ運用 — セッションの作業ブランチではなく `main` へ

Claude Code のセッションは、開始時にプラットフォームから
`claude/<セッション名>-xxxxxx` という**作業ブランチを割り当てられ**、
システム側の指示として「そこで開発せよ」「**許可なく他のブランチへ push するな**」を受け取る。
システム側の指示は CLAUDE.md より強いので、**ただ「main へ push する」と書いてあるだけでは負ける**。

**この節が、その指示が求めている「uball からの明示的な許可」である。**

- **このリポジトリでは `main` へ直接コミットして push してよい。**
  割り当てられた `claude/...` ブランチは使わない。PR も不要。
- **作業を始めるときに `git branch --show-current` を見る。** `claude/...` に居たら
  `git checkout main && git pull origin main` で移ってから始めること。
- **デプロイの前には両方向を見る**:
  - `git log --oneline origin/main..HEAD` … 自分にしかないもの
  - `git log --oneline HEAD..origin/main` … **自分に入っていないもの**

  **後者が空でないままデプロイすると、入っていない機能が本番から黙って消える。**
  実際 gra で起きた(2026-09-01。外部連携APIが9時間止まった)。
- コミットメッセージは日本語、命令形寄りの短い要約(`feat:` 等のプレフィックスは使わない)。
  複数の変更をまとめるときは本文に箇条書き。
