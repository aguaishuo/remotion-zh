#!/usr/bin/env bash
# 只克隆第一梯队 5 个：Claude Code 自动化 + 可复用组件
set -euo pipefail
cd "$(dirname "$0")/.."

REPOS=(
  "digitalsamba/claude-code-video-toolkit|Claude视频工具包-claude-code-video-toolkit"
  "jhartquist/claude-remotion-kickstart|Claude启动器-claude-remotion-kickstart"
  "av/remotion-bits|动画组件库-remotion-bits"
  "stefanwittwer/remotion-animated|优雅动画-remotion-animated"
  "reactvideoeditor/clippkit|可复用组件-clippkit"
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
done

echo ""
echo "✓ 第一梯队 5 个完成（Claude Code 自动化 + 可复用组件）"
