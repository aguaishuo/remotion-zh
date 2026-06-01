#!/usr/bin/env bash
# 克隆全部 90 个第三方案例源码 + 22 个 Remotion 官方模板到本地
# 用法: ./scripts/fetch-all.sh [--lite]
#   --lite  跳过 Brainrot.js 大资产（pose/background ~1.5GB）
set -euo pipefail

cd "$(dirname "$0")/.."
LITE=0
[[ "${1:-}" == "--lite" ]] && LITE=1

command -v jq >/dev/null 2>&1 || { echo "需要安装 jq: brew install jq / apt install jq"; exit 1; }
command -v git >/dev/null 2>&1 || { echo "需要安装 git"; exit 1; }

CASE_ROOT="案例展示Showcase/案例源码"
mkdir -p "$CASE_ROOT"

echo "==> 克隆 90 个第三方案例源码（depth=1，约 5-10GB）"
TOTAL=$(jq 'length' data/案例列表.json)
i=0
jq -r '.[] | "\(.folder)\t\(.github_url)"' data/案例列表.json | while IFS=$'\t' read -r folder url; do
  i=$((i+1))
  [[ -z "$url" ]] && { echo "[$i/$TOTAL] 跳过（无 GitHub URL）: $folder"; continue; }
  if [[ -d "$CASE_ROOT/$folder/.git" ]]; then
    echo "[$i/$TOTAL] 已存在，跳过: $folder"
    continue
  fi
  echo "[$i/$TOTAL] 克隆: $folder ← $url"
  if git clone --depth=1 "$url" "$CASE_ROOT/$folder" 2>&1 | tail -3; then
    # Brainrot.js lite: 删除非音频大资产
    if [[ "$LITE" == "1" && "$folder" == "Brainrot文转视频-brainrot.js" ]]; then
      rm -rf "$CASE_ROOT/$folder/generate/public/pose" 2>/dev/null || true
      rm -rf "$CASE_ROOT/$folder/generate/public/background" 2>/dev/null || true
      echo "  → lite 模式：已删除 pose/background (~1.5GB)"
    fi
  fi
done

echo ""
echo "==> 克隆 22 个 Remotion 官方模板（sparse-checkout 自 remotion-dev/remotion monorepo）"
TPL_REPO=https://github.com/remotion-dev/remotion
if [[ ! -d "_remotion_monorepo" ]]; then
  git clone --depth=1 --filter=blob:none --sparse "$TPL_REPO" _remotion_monorepo
  cd _remotion_monorepo
  TPL_PATHS=$(jq -r '.[] | "packages/template-" + .en_slug' ../data/模板列表.json | tr '\n' ' ')
  git sparse-checkout set $TPL_PATHS
  cd ..
fi

jq -r '.[] | "\(.folder)\t\(.en_slug)"' data/模板列表.json | while IFS=$'\t' read -r folder slug; do
  src="_remotion_monorepo/packages/template-$slug"
  if [[ ! -d "$src" ]]; then
    echo "[警告] 模板源缺失: $src"
    continue
  fi
  if [[ -d "$folder" ]]; then
    echo "已存在，跳过: $folder"
    continue
  fi
  cp -R "$src" "$folder"
  echo "✓ $folder"
done

echo ""
echo "==> 全部完成"
echo "本地源码大小: $(du -sh "$CASE_ROOT" 2>/dev/null | cut -f1)"
echo "本地模板大小: $(du -sh 高性能2D-skia 抖音竖屏短视频-tiktok 2>/dev/null | head -1)"
echo "现在可以离线打开 预览首页.html / index.html 看完整 191 卡片"
