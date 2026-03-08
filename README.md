# biz-claude

ビジネスユーザー向けClaude Code設定集。PM、営業、企画などビジネス業務を効率化するためのワークフロー、スキル、コマンドを提供します。

## 特徴

- **構造化されたワークフロー**: 調査→作成→レビュー→完了の明確なフロー
- **専用スキル**: 引き継ぎ資料作成、リサーチ、議事録作成、PRD作成など
- **知見の蓄積**: 作業で得た知見を自動保存し、将来のタスクで再利用
- **ガイドツアー**: `/guide`コマンドで使い方を学べる

## インストール

### 方法1: /setupコマンド（推奨）

```bash
# 1. リポジトリをクローン
git clone https://github.com/xxarupakaxx/biz-claude.git
cd biz-claude

# 2. Claude Codeを起動してセットアップコマンドを実行
claude
/setup
```

対話形式で以下を選択できます：
- **新規インストール**: 全ファイルをコピー
- **追加のみ**: 既存ファイルを保持し、新しいファイルのみ追加
- **選択インストール**: skills/やcommands/など、選んだものだけコピー

### 方法2: 手動インストール

```bash
# 1. リポジトリをクローン
git clone https://github.com/xxarupakaxx/biz-claude.git
cd biz-claude

# 2. ~/.claude/にコピー
cp CLAUDE.md ~/.claude/
cp -r context ~/.claude/
cp -r rules ~/.claude/
cp -r skills ~/.claude/
cp -r commands ~/.claude/
cp -r hooks ~/.claude/
cp -r docs ~/.claude/

# 3. 確認
claude
/guide
```

## ディレクトリ構造

```
~/.claude/
├── CLAUDE.md                    # グローバル設定
├── context/
│   ├── workflow-rules.md        # ワークフロー詳細
│   └── memory-file-formats.md   # メモリファイル形式
├── rules/
│   ├── documentation.md         # ドキュメント作成ルール
│   └── knowledge-management.md  # 知見管理ルール
├── skills/
│   ├── handover-docs/           # 引き継ぎ資料作成
│   ├── business-research/       # リサーチ・調査
│   ├── meeting-notes/           # 議事録作成
│   ├── report-writing/          # レポート作成
│   ├── prd-writing/             # PRD作成
│   ├── brainstorming/           # アイデア探索
│   ├── knowledge-capture/       # 知見キャプチャ
│   ├── agent-memory/            # メモリ操作
│   ├── cleanup-knowledge/       # 知見整理
│   ├── update-inst/             # 設定改善
│   ├── ship-learn-next/         # 学習→実行計画
│   └── kaizen/                  # 継続的改善
├── commands/
│   ├── guide.md                 # ガイドツアー
│   ├── workflow.md              # ワークフロー確認
│   ├── skills.md                # スキル一覧
│   ├── lfg.md                   # 自律ワークフロー
│   └── setup.md                 # セットアップコマンド
├── hooks/
│   └── check-dangerous-command.sh  # 危険コマンド検出
├── docs/
│   └── CHEATSHEET.md            # コマンド早見表（印刷用）
└── agents/
    ├── researcher.md            # リサーチャーエージェント
    └── reviewer.md              # レビューアーエージェント
```

## 使い方

### 初めての方

```bash
claude
```

起動後、以下のコマンドを実行:

```
/guide
```

### コマンド一覧

| コマンド | 説明 | 対象者 |
|---------|------|--------|
| `/guide` | ガイドツアー：全体像、基本的な使い方、ユースケース例 | 初めての人 |
| `/skills` | スキル詳細リファレンス：各スキルの目的、使い方、出力形式 | 使い方を調べたい人 |
| `/workflow` | 作業フローの詳細を確認 | フローを理解したい人 |
| `/lfg <タスク>` | 自律ワークフローでタスクを実行 | タスクを任せたい人 |
| `/setup` | 対話型セットアップ | インストール時 |

### チートシート

印刷して手元に置ける早見表: `docs/CHEATSHEET.md`

### スキル一覧

#### ドキュメント作成系

| スキル | 説明 | 使い方の例 |
|-------|------|-----------|
| `handover-docs` | 引き継ぎ資料作成 | 「このリポジトリの引き継ぎ資料を作って」 |
| `meeting-notes` | 議事録作成 | 「この会議メモを整理して」 |
| `report-writing` | レポート作成 | 「調査結果をレポートにまとめて」 |
| `prd-writing` | PRD作成 | 「新機能のPRDを作成したい」 |

#### リサーチ・企画系

| スキル | 説明 | 使い方の例 |
|-------|------|-----------|
| `business-research` | リサーチ・調査 | 「競合Aについて調べて」 |
| `brainstorming` | アイデア探索 | 「新機能のアイデアを整理したい」 |

#### 知見管理系

| スキル | 説明 | 使い方の例 |
|-------|------|-----------|
| `knowledge-capture` | 知見キャプチャ | 「今回の知見を保存して」 |
| `agent-memory` | メモリ操作 | 「これ覚えて」「〇〇について思い出して」 |
| `cleanup-knowledge` | 知見整理 | 「溜まった知見を整理して」 |

#### 改善・学習系

| スキル | 説明 | 使い方の例 |
|-------|------|-----------|
| `update-inst` | 設定改善 | 「さっきの間違いを防ぐように設定を更新して」 |
| `ship-learn-next` | 学習→実行計画 | 「この記事の内容をアクションプランにして」 |
| `kaizen` | 継続的改善 | 「この業務フローを改善したい」 |

## ユースケース

### 引き継ぎ資料の作成

```
ユーザー: このリポジトリの引き継ぎ資料を作って
         https://github.com/company/project

Claude:
1. deepwikiでリポジトリ構造を分析
2. README、設定ファイルを読み取り
3. 構造化された引き継ぎ資料を作成
```

### 競合調査

```
ユーザー: 競合Aについて調べて

Claude:
1. 調査の観点を確認（機能比較？価格比較？）
2. WebSearchで情報収集
3. 構造化されたレポートを作成
```

### 会議メモの整理

```
ユーザー: [会議メモを貼り付け]
         議事録にまとめて

Claude:
1. 会議メモを構造化
2. アクションアイテムを抽出
3. 議事録として出力
```

## 知見の蓄積

作業で得た知見は自動的に保存されます:

```
.local/
├── memories/     # 検索用インデックス
│   └── research/
│       └── competitor-analysis.md
└── solutions/    # 詳細な知見
    └── research/
        └── competitor-analysis-framework.md
```

次回のタスクでは、過去の知見が自動的に参照されます。

## 安全対策

ビジネスユーザーが安心して使えるように、以下の安全対策が組み込まれています：

### 危険コマンドの検出

`hooks/check-dangerous-command.sh`が以下のコマンドを検出し、実行前に確認を求めます：

| コマンド | 説明 |
|---------|------|
| `rm -rf` | ファイル/ディレクトリを再帰的に強制削除 |
| `git push --force` | リモートの履歴を上書き |
| `git reset --hard` | コミットされていない変更を全て破棄 |
| `git clean -fd` | 追跡されていないファイルを全て削除 |

### コマンドの説明

Claudeはシェルコマンドを実行する前に、何をするコマンドか説明します。

## カスタマイズ

### スキルの追加

`skills/`に新しいディレクトリを作成し、`SKILL.md`を配置:

```markdown
---
name: my-skill
description: "スキルの説明"
type: component|interactive|workflow
---

# スキル名

## Purpose
[目的]

## Application
[使い方]
```

### コマンドの追加

`commands/`に新しい`.md`ファイルを作成:

```markdown
---
description: "コマンドの説明"
---

# コマンド名

[コマンドの内容]
```

## 参考リソース

このプロジェクトは以下を参考にしています:

- [deanpeters/Product-Manager-Skills](https://github.com/deanpeters/Product-Manager-Skills): PM向けスキルフレームワーク
- [carlvellotti/claude-code-pm-course](https://github.com/carlvellotti/claude-code-pm-course): PM向けClaude Codeコース
- [prodmgmt.world](https://www.prodmgmt.world/claude-code): PM向けClaude Codeガイド

## ライセンス

MIT
