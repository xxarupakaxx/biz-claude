#!/bin/bash
# 危険なコマンドを検出して確認を求めるhook
# PreToolUse: Bash で実行される

# 標準入力からJSONを読み取る
INPUT=$(cat)

# Bashツールのcommandパラメータを抽出
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# コマンドが空なら何もしない
if [ -z "$COMMAND" ]; then
  exit 0
fi

# 危険なコマンドパターンを定義
DANGEROUS_PATTERNS=(
  "rm -rf"
  "rm -fr"
  "rm .*-r"
  "git push.*--force"
  "git push.*-f"
  "git reset --hard"
  "git clean -fd"
  "> /dev/"
  "chmod 777"
  ":(){ :|:& };:"
)

# 説明メッセージを定義
declare -A EXPLANATIONS
EXPLANATIONS["rm -rf"]="ファイル/ディレクトリを再帰的に強制削除します"
EXPLANATIONS["rm -fr"]="ファイル/ディレクトリを再帰的に強制削除します"
EXPLANATIONS["rm .*-r"]="ファイル/ディレクトリを再帰的に削除します"
EXPLANATIONS["git push.*--force"]="リモートの履歴を上書きします（危険）"
EXPLANATIONS["git push.*-f"]="リモートの履歴を上書きします（危険）"
EXPLANATIONS["git reset --hard"]="コミットされていない変更を全て破棄します"
EXPLANATIONS["git clean -fd"]="追跡されていないファイルを全て削除します"
EXPLANATIONS["chmod 777"]="全ユーザーに全権限を付与します（セキュリティリスク）"

# 各パターンをチェック
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    explanation="${EXPLANATIONS[$pattern]:-このコマンドは危険な操作を含む可能性があります}"

    # 確認を求めるレスポンスを返す
    echo "{\"decision\": \"ask\", \"message\": \"$explanation: $COMMAND\"}"
    exit 0
  fi
done

# 問題なければ何も返さない
exit 0
