---
name: cleanup-knowledge
description: "知見ファイルのクリーンアップを実行。30日未参照のアーカイブ候補、同一タグの統合候補を確認し、ユーザー承認のもとで整理を行う。手動で /cleanup-knowledge 実行時に使用。"
---

# Cleanup Knowledge

知見ファイル（memories/、solutions/）の整理・統合を行う。

## トリガー

- `/cleanup-knowledge` で明示的に実行
- 知見が溜まってきて整理したい場合

## 実行フロー

### Step 1: 現状分析

```bash
MEMORY_DIR=".local"
INDEX_FILE="$MEMORY_DIR/index.json"

# index.jsonの内容を確認（存在する場合）
cat "$INDEX_FILE" 2>/dev/null | jq '.files | to_entries | sort_by(.value.ref_count) | reverse'

# 30日未参照のファイルを特定
jq -r '.files | to_entries[] | select(.value.last_accessed < "THRESHOLD_DATE") | .key' "$INDEX_FILE" 2>/dev/null
```

### Step 2: アーカイブ候補の確認

30日以上参照されていないファイルをリスト:

```markdown
## アーカイブ候補（30日未参照）

| ファイル | 最終参照 | 参照回数 |
|---------|---------|---------|
| solutions/xxx.md | 2026-01-15 | 2 |
| memories/yyy.md | 2026-01-20 | 0 |
```

AskUserQuestionで各ファイルについて確認:
- 「アーカイブする」→ `.local/archived/` に移動
- 「保持する」→ last_accessedを今日に更新
- 「削除する」→ 完全削除（要確認）

### Step 3: 統合候補の確認

同一タグが3件以上あるトピックをリスト:

```markdown
## 統合候補（類似トピック）

### タグ: "research" (4件)
1. solutions/research/competitor-analysis.md
2. solutions/research/market-trends.md
3. solutions/research/user-interview.md
4. memories/research/industry-report.md
```

AskUserQuestionで確認:
- 「統合する」→ 新しい統合ドキュメントを提案
- 「そのまま維持」→ スキップ

### Step 4: 統合実行（承認された場合）

1. 統合対象ファイルの内容を読み取り
2. 新しい統合ドキュメントを生成
3. **提案として表示**
4. ユーザー承認後に保存
5. 元ファイルをアーカイブ（削除ではない）

### Step 5: インデックス更新

```bash
# アーカイブしたファイルをindex.jsonから削除
jq 'del(.files["archived/path"])' "$INDEX_FILE" > "$INDEX_FILE.tmp"
mv "$INDEX_FILE.tmp" "$INDEX_FILE"

# 新規統合ファイルをindex.jsonに追加
jq --arg path "new/path.md" '.files[$path] = {"ref_count": 0, "created": "TODAY"}' "$INDEX_FILE" > "$INDEX_FILE.tmp"
mv "$INDEX_FILE.tmp" "$INDEX_FILE"
```

## アーカイブディレクトリ構造

```
.local/
├── solutions/          # アクティブな知見
├── memories/           # アクティブなインデックス
├── archived/           # アーカイブされた知見
│   ├── solutions/
│   └── memories/
└── index.json          # 参照回数トラッキング
```

## 禁止事項

- ユーザー承認なしの削除・移動
- アーカイブではなく即削除（復元可能性を維持）
- index.jsonの手動編集
