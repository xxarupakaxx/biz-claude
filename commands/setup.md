# biz-claude セットアップ

biz-claudeの設定をユーザーの環境にセットアップする対話型コマンド。

## 実行手順

### Step 1: 現在の状態を確認

```bash
# 既存の~/.claude/の状態を確認
ls -la ~/.claude/ 2>/dev/null || echo "~/.claude/が存在しません"
```

### Step 2: セットアップ方法を選択

AskUserQuestionで確認:

**質問**: どのようにセットアップしますか？

| 選択肢 | 説明 |
|-------|------|
| 新規インストール | ~/.claude/に全ファイルをコピー（既存があれば上書き確認） |
| 追加のみ | 既存ファイルを保持し、新しいファイルのみ追加 |
| 特定のファイルのみ | skills/やcommands/など、選んだものだけコピー |

### Step 3: コピー対象の説明

コピーされるファイル/ディレクトリを説明:

| 対象 | 内容 |
|------|------|
| `CLAUDE.md` | メイン設定ファイル |
| `context/` | ワークフロールール等 |
| `rules/` | 各種ルール |
| `skills/` | スキル定義（12個） |
| `commands/` | コマンド定義 |
| `hooks/` | 危険コマンド検出hook |
| `docs/` | チートシート等 |

### Step 4: 実行

選択に応じてファイルをコピー:

```bash
# 例: 全ファイルコピー
cp -r skills/ ~/.claude/skills/
cp -r commands/ ~/.claude/commands/
cp -r context/ ~/.claude/context/
cp -r rules/ ~/.claude/rules/
cp -r hooks/ ~/.claude/hooks/
cp CLAUDE.md ~/.claude/CLAUDE.md
```

**既存ファイルがある場合**:
- 差分を表示して上書きするか確認
- または既存をバックアップしてからコピー

### Step 5: 確認

```bash
# コピー結果を確認
ls -la ~/.claude/
```

### Step 6: 完了メッセージ

```
セットアップ完了！

次のステップ:
1. 任意のディレクトリで `claude` を起動
2. `/guide` でガイドツアーを開始

チートシートは docs/CHEATSHEET.md を参照してください。
```

## 注意事項

- 既存のCLAUDE.mdがある場合は、マージするか上書きするか必ず確認
- user-level設定（~/.claude/）への変更であることを明示
- バックアップを推奨
