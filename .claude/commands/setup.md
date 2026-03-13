# biz-claude セットアップ

biz-claudeの設定をユーザーの `~/.claude/` にコピーする対話型コマンド。
既存ファイルを壊さないことを最優先とする。

## 実行手順

### Step 1: 事前説明

まずユーザーに以下を説明する:

```
このコマンドは、biz-claudeの設定ファイルをあなたの ~/.claude/ にコピーします。

■ コピーされるもの
  - CLAUDE.md（グローバル設定）
  - context/（ワークフロールール）
  - rules/（ドキュメント作成・知見管理ルール）
  - skills/（17個のスキル定義）
  - commands/（コマンド定義）
  - hooks/（危険コマンド検出）
  - agents/（サブエージェント定義）
  - docs/（チートシート）

■ 安全対策
  - デフォルトでは既存ファイルを上書きしません（追加のみ）
  - 上書きが必要な場合は個別に確認します
```

### Step 2: 現在の状態を確認

```bash
# ~/.claude/の現在の状態を確認
ls -la ~/.claude/ 2>/dev/null || echo "~/.claude/が存在しません"
```

既存ファイルがある場合は、重複するファイルをリストアップしてユーザーに見せる:

```bash
# 重複チェック: biz-claudeと同名のファイルが~/.claude/に既にあるか
for f in $(cd .claude && find . -type f -not -name 'settings*'); do
  if [ -f "$HOME/.claude/$f" ]; then
    echo "既存: $f"
  fi
done
```

### Step 3: セットアップ方法を選択

AskUserQuestionで確認:

**質問**: どのようにセットアップしますか？

| 選択肢 | 説明 |
|-------|------|
| 追加のみ（推奨） | 既存ファイルは一切変更せず、新しいファイルだけ追加 |
| 全て上書き | 既存ファイルも含めてbiz-claudeの内容で上書き（既存のカスタマイズは失われます） |
| 選択コピー | ファイルごとに追加/上書き/スキップを選択 |

### Step 4: 実行

選択に応じてコピー:

**追加のみの場合:**
```bash
rsync -a --ignore-existing .claude/ ~/.claude/
```

**全て上書きの場合:**
```bash
rsync -a .claude/ ~/.claude/
```
※settings.json、settings.local.jsonは除外（ユーザー固有の設定のため）

**選択コピーの場合:**
各ディレクトリ（skills/, commands/, rules/等）ごとにAskUserQuestionで
追加/上書き/スキップを確認してからコピー。

### Step 5: 結果報告

```bash
# コピー結果を確認
ls -la ~/.claude/
```

コピーされたファイル数と、スキップされたファイル数を報告。

### Step 6: 完了メッセージ

```
セットアップ完了！

次のステップ:
1. 任意のディレクトリで `claude` を起動
2. `/guide` でガイドツアーを開始

チートシートは ~/.claude/docs/CHEATSHEET.md を参照してください。
```

## 注意事項

- settings.json / settings.local.json はコピー対象外（ユーザー固有の設定）
- user-level設定（~/.claude/）への変更であることを必ず事前に説明する
- 既存ファイルの上書きは明示的な同意がある場合のみ実行する
