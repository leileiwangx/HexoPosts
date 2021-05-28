#!/usr/bin/env bash

dir="_posts"

rm -fr $dir/*
cp -r ../hexo-mini/source/$dir/* $dir/

git add $dir
git commit -m "sync _posts"
git push

