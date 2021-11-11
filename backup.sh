#!/bin/zsh
cp themes/suka/_config.yml _config.suka.yml

echo "backup success"

git add -A

echo "add success"

git commit -m " backup config "

echo "commit success"

git push

echo "push success"