#!/usr/bin/env bash
# 一键发布：把当前目录推到 GitHub，并镜像到 gh-pages 分支（Pages 从这里出）
# 用法：./deploy.sh
set -euo pipefail
cd "$(dirname "$0")"

REMOTE="${REMOTE:-git@github.com:fengchao0707/dino-tech-state.git}"

if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$REMOTE"
  echo "added remote: $REMOTE"
fi

git add -A
git -c user.name="Feng Chao" -c user.email="fengchao@dinoai.ai" \
    commit -m "update: $(date '+%Y-%m-%d %H:%M')" || echo "no changes to commit"

git push origin main
git push origin main:gh-pages --force

echo
echo "已发布： https://fengchao0707.github.io/dino-tech-state/"
echo "（首次推送后 GitHub 需要几十秒构建，之后每次更新约 1 分钟生效）"
