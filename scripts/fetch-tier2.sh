#!/usr/bin/env bash
# 只克隆第二梯队 5 个：AI 短视频/管线
set -euo pipefail
cd "$(dirname "$0")/.."

LITE=0
[[ "${1:-}" == "--lite" ]] && LITE=1

REPOS=(
  "gyoridavid/short-video-maker|短视频批量生成-short-video-maker"
  "noahgsolomon/brainrot.js|Brainrot文转视频-brainrot.js"
  "tsensei/OpenReels|AI主题视频管线-OpenReels"
  "ayush-that/jiang-clips|长视频切片管线-jiang-clips"
  "ezedinff/TikTok-Forge|TikTok生成管线-TikTok-Forge"
)

mkdir -p "案例展示Showcase/案例源码"
for entry in "${REPOS[@]}"; do
  IFS='|' read -r repo folder <<<"$entry"
  target="案例展示Showcase/案例源码/$folder"
  if [[ -d "$target/.git" ]]; then
    echo "已存在，跳过: $folder"
    continue
  fi
  echo "克隆 $folder ← https://github.com/$repo"
  git clone --depth=1 "https://github.com/$repo" "$target"
  if [[ "$LITE" == "1" && "$folder" == "Brainrot文转视频-brainrot.js" ]]; then
    rm -rf "$target/generate/public/pose" "$target/generate/public/background" 2>/dev/null
    echo "  → lite 模式：已删除 pose/background (~1.5GB)"
  fi
done

echo ""
echo "✓ 第二梯队 5 个完成（AI 短视频/管线）"
[[ "$LITE" != "1" ]] && echo "  ⚠️ Brainrot.js 含 pose/background ~1.5GB 非音频资产；要剥离请加 --lite"
