#!/usr/bin/env bash
# 重新拉取 90 个第三方仓库的 GitHub opengraph 社交卡（rate limit: 未登录 60/h，登录后 5000/h）
set -euo pipefail
cd "$(dirname "$0")/.."

command -v jq >/dev/null 2>&1 || { echo "需要 jq"; exit 1; }
mkdir -p "_社交卡缓存"

jq -r '.[] | "\(.folder)\t\(.owner)\t\(.repo)"' data/案例列表.json | while IFS=$'\t' read -r folder owner repo; do
  [[ -z "$owner" || -z "$repo" ]] && continue
  out="_社交卡缓存/${folder}.png"
  url="https://opengraph.githubassets.com/$(uuidgen | tr 'A-Z' 'a-z')/$owner/$repo"
  if curl -fsSL -o "$out.tmp" "$url"; then
    mv "$out.tmp" "$out"
    echo "✓ $folder"
  else
    rm -f "$out.tmp"
    echo "✗ $folder ($url)"
  fi
  sleep 1   # 控速避免 rate limit
done

echo ""
echo "✓ 完成。共 $(ls _社交卡缓存/*.png 2>/dev/null | wc -l | tr -d ' ') 张"
