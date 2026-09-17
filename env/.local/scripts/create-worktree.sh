#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 || $# -gt 3 ]]; then
  printf 'Usage: %s <branch> [directory] [base-ref]\n' "$0" >&2
  exit 64
fi

branch=$1
repo_root=$(git rev-parse --show-toplevel)
repo_parent=$(dirname "$repo_root")
repo_name=$(basename "$repo_root")
directory=${2:-"$repo_parent/${repo_name}-${branch//\//-}"}
base_ref=${3:-main}

if [[ -e "$directory" ]]; then
  printf 'Worktree directory already exists: %s\n' "$directory" >&2
  exit 1
fi

if git show-ref --verify --quiet "refs/heads/$branch"; then
  git worktree add "$directory" "$branch"
else
  git worktree add -b "$branch" "$directory" "$base_ref"
fi

printf 'Worktree created at %s\n' "$directory"
