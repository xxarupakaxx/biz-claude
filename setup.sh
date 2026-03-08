#!/bin/bash

# biz-claude setup script
# ~/.claude/ にファイルを強制コピーする

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude"

echo "==================================="
echo "  biz-claude セットアップ"
echo "==================================="
echo ""
echo "コピー元: $SCRIPT_DIR"
echo "コピー先: $TARGET_DIR"
echo ""

# ~/.claude/ が存在しない場合は作成
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 $TARGET_DIR を作成..."
    mkdir -p "$TARGET_DIR"
fi

# コピー対象のディレクトリとファイル
DIRS=("context" "rules" "skills" "commands" "agents")
FILES=("CLAUDE.md")

# ディレクトリをコピー
for dir in "${DIRS[@]}"; do
    if [ -d "$SCRIPT_DIR/$dir" ]; then
        echo "📂 $dir/ をコピー中..."
        mkdir -p "$TARGET_DIR/$dir"
        cp -rf "$SCRIPT_DIR/$dir"/* "$TARGET_DIR/$dir/"
    fi
done

# ファイルをコピー
for file in "${FILES[@]}"; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        echo "📄 $file をコピー中..."
        cp -f "$SCRIPT_DIR/$file" "$TARGET_DIR/$file"
    fi
done

echo ""
echo "==================================="
echo "  セットアップ完了"
echo "==================================="
echo ""
echo "次のステップ:"
echo "  1. claude を起動"
echo "  2. /guide でガイドツアーを開始"
echo ""
echo "コマンド一覧:"
echo "  /guide    - ガイドツアー"
echo "  /workflow - ワークフロー確認"
echo "  /skills   - スキル一覧"
echo "  /lfg      - 自律ワークフロー"
echo ""
