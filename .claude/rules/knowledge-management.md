# Knowledge Management Rules

知見管理（memories/、solutions/）に適用されるルール。

## 保存の原則

### 保存すべき知見

- 新しく発見した有用な情報
- 問題解決のプロセスと結果
- 再利用可能なテンプレート・フレームワーク
- 失敗から学んだ教訓

### 保存不要なもの

- 一般的に知られている情報
- 一度きりの作業で再利用性がないもの
- 機密情報・個人情報

## ファイル形式

### memories/（インデックス）

```yaml
---
summary: "1-2行の要約（検索時の判断材料）"
created: YYYY-MM-DD
tags: [tag1, tag2]
category: research|handover|meeting|report|strategy
---

# タイトル

## 要点
- ポイント1
- ポイント2

## 詳細
→ solutions/を参照（必要に応じて）
```

### solutions/（詳細）

```yaml
---
title: "知見のタイトル"
category: "research|handover|meeting|report|strategy"
tags: [tag1, tag2]
summary: "1行サマリー"
created: YYYY-MM-DD
---

# タイトル

## 背景
[コンテキスト]

## 内容
[詳細な知見・手法]

## ポイント
- ポイント1
- ポイント2
```

## 検索方法

```bash
# サマリー検索
rg "^summary:" .local/memories/ --no-ignore --hidden

# キーワード検索
rg "^summary:.*keyword" .local/memories/ -i

# タグ検索
rg "^tags:.*keyword" .local/memories/ -i

# カテゴリ検索
rg "^category:.*research" .local/memories/
```

## メンテナンス

- 古い情報は定期的に更新
- 重複する知見は統合
- 不要になった知見はアーカイブ
