#!/usr/bin/env bash

echo "deploy"
## hexo deploy
hexo d -g

echo "git push"

git status
git add .
git commit -am "update post"
git push origin master