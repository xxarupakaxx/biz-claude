# biz-claude - ビジネスユーザー向けClaude Code設定

## はじめに

初めての方は `/guide` でガイドツアーを開始してください。

## 作業フロー

ビジネスタスクを効率的に進めるための5つのPhase:

0. **準備**: メモリディレクトリ作成 → 05_log.md初期化 → 過去知見検索
1. **調査**: 情報収集 + 外部リソース参照（deepwiki/WebSearch/Context7）
2. **作成**: ドキュメント・成果物の作成
3. **レビュー**: 品質確認・整合性チェック
4. **完了**: 完了報告 + 知見保存

詳細: Readで `@context/workflow-rules.md` を参照

## メモリ管理

- ディレクトリ: `.local/memory/YYMMDD_<task_name>/`
- **YYMMDD**: システムプロンプトの`Today's date`から取得
- 作業ログ: 05_log.md に実施内容を逐次記録
- 知見保存: memories/ に要約、solutions/ に詳細を保存

## コンテキスト復元

セッション開始時に`.local/HANDOVER.md`が存在すれば読み込み、前のセッション状態を復元。

## 利用可能なコマンド

| コマンド | 説明 |
|---------|------|
| `/guide` | ガイドツアー（初めての方はこちら） |
| `/workflow` | 作業フローの詳細を確認 |
| `/skills` | 利用可能なスキル一覧 |
| `/lfg <タスク>` | 自律ワークフローでタスクを実行 |

## 利用可能なスキル

| スキル | 説明 |
|-------|------|
| `handover-docs` | 引き継ぎ資料の作成 |
| `business-research` | リサーチ・調査 |
| `meeting-notes` | 議事録・MTGサマリー作成 |
| `report-writing` | レポート作成 |
| `knowledge-capture` | 知見のキャプチャ・保存 |
| `prd-writing` | PRD（製品要件定義書）作成 |
| `brainstorming` | アイデア探索・設計 |
| `jobs-to-be-done` | 顧客ニーズのJTBD分析 |
| `user-story` | ユーザーストーリー作成 |
| `user-story-mapping` | ストーリーマップ作成 |
| `prioritization-advisor` | 優先順位付け支援 |
| `market-sizing` | 市場規模試算（TAM/SAM/SOM） |
| `update-inst` | 設定の改善・最適化 |
| `agent-memory` | 「覚えて」「思い出して」でメモリ操作 |
| `ship-learn-next` | 学習内容を実行計画に変換 |
| `kaizen` | 業務の継続的改善 |
| `cleanup-knowledge` | 知見ファイルの整理・統合 |
| `summarizing-daily-work` | 日報の自動生成（「日報を書いて」「今日のまとめ」） |

## 質問

曖昧な点があれば必ずAskUserQuestionで質問してください。推測で進めず、確認を優先。

## コマンド実行ルール

**ビジネスユーザー向けの安全対策**

1. **実行前に説明**: シェルコマンド（ls, git, rm等）を実行する際は、何をするコマンドか簡潔に説明すること
2. **危険なコマンドは確認**: ファイル削除、git force push等の破壊的操作は実行前にユーザーに確認すること
3. **Hooksによる保護**: `hooks/check-dangerous-command.sh`が危険なコマンドを自動検出して確認を求める

## 禁止事項

- 05_log.mdを更新せずに次のPhaseに進むこと
- レビューを実行せずに完了報告すること
- 知見を保存せずにセッションを終了すること（価値ある発見があった場合）
