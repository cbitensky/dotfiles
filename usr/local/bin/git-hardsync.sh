#!/bin/sh -e
git checkout --detach
git branch | grep -v "HEAD detached" | xargs git branch -D
git fetch --prune
git checkout `git branch -r | grep -Po '/HEAD -> [^/]+/\K.*'`
git push --mirror
git pull

git reflog expire --expire=all --all
git prune
git gc --aggressive
[ "$REPACK" != "" ] && git repack -A -d -f -F --unpack-unreachable=all --window=4095 --depth=4095

