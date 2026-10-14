#!/bin/bash
set -euo pipefail

# Cleanup remote branches except main and test.
# Run this from a local clone that has write access to origin (your machine or a runner).

git fetch --prune --all
for b in $(git for-each-ref --format='%(refname:short)' refs/remotes/origin | sed 's|origin/||' | grep -v -E '^(main|test)$' | sort -u); do
  echo "Deleting remote branch: $b"
  git push origin --delete "$b"
done

echo "Done. To delete local branches, run: git branch -D <branch-name>"
