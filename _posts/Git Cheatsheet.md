---
title: Git Cheatsheet
date: 2021-05-27 11:10:28
tags:
---

branch  

	git checkout <branch>
	git checkout -b <branch>
	git branch -a
delete branch  

	git branch -d <branch>
	git push origin --delete <branch>

combine commits  

    git rebase -i HEAD~n
    git push -f

abandon local change:  

    git fetch --all
    git reset --hard origin/master
    git pull


Git History  

	April 2005
	Linux Torvalds
	replacement for bitkeeper to manage Linux kernel source code
	open source and free software
	distributed version control
	compatible with linux ,macOS windows
	faster than other SCMs(100times in some cases)
	better safeguards against data corruption
	github launched in 2008
	purchased by Microsoft 2018

configuration:  

	system : etc/gitconfig            git config --system
	user: ~/.gitconfig                git config --global
	project: my_project/.git/config   git config