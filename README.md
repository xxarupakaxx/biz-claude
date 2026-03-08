# biz-claude

ビジネスユーザー向けClaude Code設定集。PM、営業、企画などビジネス業務を効率化するためのワークフロー、スキル、コマンドを提供します。

## 特徴

- **構造化されたワークフロー**: 調査→作成→レビュー→完了の明確なフロー
- **専用スキル**: 引き継ぎ資料作成、リサーチ、議事録作成、PRD作成など
- **知見の蓄積**: 作業で得た知見を自動保存し、将来のタスクで再利用
- **ガイドツアー**: `/guide`コマンドで使い方を学べる

## インストール

### 方法1: 手動インストール（推奨）

1. **リポジトリをクローン**

```bash
git clone https://github.com/xxarupakaxx/biz-claude.git
cd biz-claude
```

2. **~/.claude/にコピー**

```bash
# バックアップ（既存設定がある場合）
cp -r ~/.claude ~/.claude.backup

# ファイルをコピー
cp CLAUDE.md ~/.claude/
cp -r context ~/.claude/
cp -r rules ~/.claude/
cp -r skills ~/.claude/
cp -r commands ~/.claude/
cp -r agents ~/.claude/
```

3. **確認**

```bash
# Claude Codeを起動
claude

# ガイドツアーを実行
/guide
```

### 方法2: 既存設定とマージ

既に`~/.claude/`に設定がある場合:

```bash
# 1. このリポジトリをクローン
git clone https://github.com/xxarupakaxx/biz-claude.git

# 2. 必要なファイルを選択してコピー
# 例: skills/のみコピー
cp -r biz-claude/skills/* ~/.claude/skills/

# 3. CLAUDE.mdはマージ（内容を確認して追記）
cat biz-claude/CLAUDE.md >> ~/.claude/CLAUDE.md
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
│   ├── knowledge-capture/       # 知見キャプチャ
│   ├── prd-writing/             # PRD作成
│   └── brainstorming/           # アイデア探索
├── commands/
│   ├── guide.md                 # ガイドツアー
│   ├── workflow.md              # ワークフロー確認
│   ├── skills.md                # スキル一覧
│   └── lfg.md                   # 自律ワークフロー
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

| コマンド | 説明 |
|---------|------|
| `/guide` | ガイドツアー（使い方を学ぶ） |
| `/workflow` | 作業フローの詳細を確認 |
| `/skills` | 利用可能なスキル一覧 |
| `/lfg <タスク>` | 自律ワークフローでタスクを実行 |

### スキル一覧

| スキル | 説明 | 使い方の例 |
|-------|------|-----------|
| `handover-docs` | 引き継ぎ資料作成 | 「このリポジトリの引き継ぎ資料を作って」 |
| `business-research` | リサーチ・調査 | 「競合Aについて調べて」 |
| `meeting-notes` | 議事録作成 | 「この会議メモを整理して」 |
| `report-writing` | レポート作成 | 「調査結果をレポートにまとめて」 |
| `prd-writing` | PRD作成 | 「新機能のPRDを作成したい」 |
| `brainstorming` | アイデア探索 | 「新機能のアイデアを整理したい」 |
| `knowledge-capture` | 知見キャプチャ | 「今回の知見を保存して」 |

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
