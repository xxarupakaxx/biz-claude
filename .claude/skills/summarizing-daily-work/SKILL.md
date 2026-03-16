---
name: summarizing-daily-work
description: "1日の作業ログ（05_log.md）から日報を自動生成。「日報を書いて」「今日のまとめ」「1日の振り返り」「日記を作成」などの依頼時に使用。やったこと・成果・課題・明日のTODO・ふりかえり（KPT）を含む。"
type: component
---

# Daily Work Summarizer

1日の作業ログ（.local/memory/YYMMDD_*/05_log.md）を読み取り、日報形式にまとめるスキル。

## 既存設定との関係

- **Phase 0-4（@context/workflow-rules.md）**: Phase 4（完了報告）の補完。日次の全タスク横断まとめ
- **メモリディレクトリ（@context/memory-file-formats.md）**: 既存の05_log.md等を入力として使用。出力は`.local/diary/`に保存

## ワークフロー

### Step 1: 対象日の特定

- デフォルト: 今日の日付（システムプロンプトの`Today's date`からYYMMDD形式で取得）
- 引数で日付指定可: `/summarizing-daily-work 260315` のように

### Step 2: PJディレクトリの探索

1. **設定ファイル確認**: `~/.claude/diary-projects.json` が存在すれば読み込む
   ```json
   {
     "projects": [
       "/path/to/project-a",
       "/path/to/project-b"
     ]
   }
   ```
2. **設定ファイルなし**: カレントPJの`.local/`のみ対象

### Step 3: ログ収集

各PJの`.local/memory/`配下から対象日のディレクトリを探索:

```
.local/memory/YYMMDD_*/
```

各ディレクトリから以下を読み取り（存在するもののみ）:

| ファイル | 抽出する情報 |
|---------|------------|
| `05_log.md` | ユーザー指示、実施内容、発見事項（**必須**） |
| `20_survey.md` | 調査結果（あれば） |
| `30_plan.md` | 作成計画（あれば） |
| `80_review.md` | レビュー結果、指摘事項（あれば） |
| `99_history.md` | 意思決定ログ（あれば） |

**IMPORTANT**: 05_log.mdは必ず読む。他のファイルは存在する場合のみ。

### Step 4: サブエージェントで要約生成

Taskツール（subagent_type: `general-purpose`、model: `haiku`）で以下を生成:

- 各タスクの要約（何をしたか、結果）
- 未完了タスクの抽出
- 課題・ブロッカーの特定
- 学びや発見の抽出

### Step 5: 日報の構成・出力

Read `references/diary-template.md` でテンプレートを取得し、以下の構成で日報を生成:

1. **今日やったこと**: タスク別に整理
2. **成果・完了したもの**: 具体的な成果物（ドキュメント、レポート等）
3. **課題・問題点**: 遭遇した問題、未解決の課題
4. **明日のTODO**: 未完了タスクをチェックリスト形式で
5. **ふりかえり（KPT）**: Keep / Problem / Try

### Step 6: 保存

- 保存先: `.local/diary/YYYY-MM-DD.md`
- diary/ディレクトリが存在しなければ作成
- 既に同日の日報があればAskUserQuestionで上書き確認

### Step 7: ユーザーに表示

日報の内容をチャット上にも表示し、修正があれば対応。

## 設定

### diary-projects.json（オプション）

複数PJ横断のため、`~/.claude/diary-projects.json` にPJパスを列挙:

```json
{
  "projects": [
    "/path/to/project-a",
    "/path/to/project-b"
  ]
}
```

未設定の場合はカレントPJのみ対象。初回実行時に設定を案内。

## Examples

### 基本的な使い方

```
ユーザー: 日報を書いて
Claude: [本日の作業ログを収集し、日報を生成]
```

### 日付指定

```
ユーザー: /summarizing-daily-work 260315
Claude: [2026年3月15日の作業ログから日報を生成]
```

## Common Pitfalls

| 落とし穴 | 結果 | 対策 |
|---------|------|------|
| 05_log.mdがない | 日報生成不可 | 「本日の作業ログが見つかりません」と報告 |
| 機密情報がログに含まれる | 漏洩リスク | 日報には含めない |
| 複数PJ設定なし | カレントPJのみ | 初回実行時に設定を案内 |

## 注意事項

- 日報生成はRead/Write操作のみ。他のファイル変更は行わない
- 05_log.mdが1つも見つからない場合は「本日の作業ログが見つかりません」と報告
- 機密情報（APIキー、パスワード等）がログに含まれていても日報には含めない

## References

- `@context/workflow-rules.md`: ビジネスワークフロー詳細
- `@context/memory-file-formats.md`: メモリファイル形式
- `@rules/documentation.md`: ドキュメント作成ルール
