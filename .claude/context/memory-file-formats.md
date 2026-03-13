# メモリファイル形式

## .local/ 全体構成

```
.local/                          # メモリディレクトリ
├── memory/                      # タスクごとの詳細ログ
│   ├── YYMMDD_handover-docs/    # YYMMDDは実際の日付（例: 260308 = 2026/03/08）
│   │   └── 05_log.md
│   └── YYMMDD_research-task/
├── memories/                    # インデックス層（検索用）
│   └── <category>/
│       └── <topic>.md
├── solutions/                   # 構造化ソリューションDB
│   ├── research/
│   ├── handover/
│   ├── meeting/
│   ├── report/
│   └── strategy/
└── HANDOVER.md                  # セッション引き継ぎ情報
```

## 2層構造

| 層 | 場所 | 用途 |
|----|------|------|
| 詳細ログ | `memory/YYMMDD_<task>/` | タスクの全記録（生ログ） |
| インデックス | `memories/<category>/` | 要約・検索用 |
| ソリューション | `solutions/<category>/` | 構造化された知見DB |

**検索フロー:**
1. `rg "^summary:" .local/memories/` でサマリー検索
2. 該当するメモリの詳細を参照

## メモリディレクトリ構成

場所: `.local/memory/YYMMDD_<task_name>/`

| ファイル | 用途 | 作成タイミング |
|---------|------|--------------|
| 05_log.md | 作業ログ（ユーザー指示とレスポンス） | タスク開始時（随時追記） |
| 20_survey.md | 調査結果 | 調査完了後 |
| 30_plan.md | 作成計画 | 計画立案後（任意） |
| 80_review.md | レビュー結果 | レビュー実施後 |
| 99_history.md | 意思決定ログ | 随時 |

## 05_log.md（重要）

ユーザーからの指示とそれに対するレスポンス・実施内容を逐一記録:

```markdown
# 作業ログ

## YYYY-MM-DD HH:MM - 初期指示

**ユーザー指示:**
> [最初の作業指示をここに記載]

**レスポンス:**
- [実施したこと1]
- [実施したこと2]

---

## YYYY-MM-DD HH:MM - 追加指示

**ユーザー指示:**
> [追加の指示]

**レスポンス:**
- [実施したこと]

---
```

## memories/（インデックス層）

場所: `.local/memories/<category>/<topic>.md`

タスク完了時に価値ある知見をインデックス化。要点のみ記載。

### フォーマット

```yaml
---
summary: "1-2行の説明（検索の判断材料）"
created: 2026-03-08
tags: [research, competitor]
category: research
related:
  - .local/memory/260308_competitor-research/
---
```

### カテゴリ

| カテゴリ | 内容 |
|---------|------|
| `research/` | 調査・リサーチ結果 |
| `handover/` | 引き継ぎ関連 |
| `meeting/` | 会議・ミーティング |
| `report/` | レポート・報告書 |
| `strategy/` | 戦略・企画 |

### 検索方法

```bash
# サマリー一覧
rg "^summary:" .local/memories/ --no-ignore --hidden

# キーワード検索
rg "^summary:.*keyword" .local/memories/ --no-ignore --hidden -i

# タグ検索
rg "^tags:.*keyword" .local/memories/ --no-ignore --hidden -i
```

## solutions/（構造化ソリューションDB）

場所: `.local/solutions/<category>/<filename>.md`

詳細な知見・解決策を構造化して保存。

### フォーマット

```yaml
---
title: "競合分析の効率的な進め方"
category: "research"
tags: [competitor, analysis, framework]
summary: "3C分析とSWOT分析を組み合わせた効率的な競合調査手法"
created: 2026-03-08
---

# 競合分析の効率的な進め方

## 背景

[なぜこの知見が有用か]

## 手法

### ステップ1
[具体的な手順]

### ステップ2
[具体的な手順]

## ポイント

- ポイント1
- ポイント2

## 参考情報

- [URL等]
```

## HANDOVER.md（セッション引き継ぎ）

セッション終了時に作成し、次回セッションで復元に使用:

```markdown
# セッション引き継ぎ

## 最終更新
YYYY-MM-DD HH:MM

## 進行中タスク
- タスク名: [概要]
- 状況: [現在の状態]
- 次のアクション: [次にやるべきこと]

## 作業ディレクトリ
.local/memory/YYMMDD_task-name/

## 重要なコンテキスト
- [覚えておくべき情報1]
- [覚えておくべき情報2]
```
