---
title: Tips of mac usage
date: 2023-03-04 22:27:34
tags:
  - mac
---

## Homebrew
在 macOS 中，您可以使用 Homebrew 这个命令行工具来安装应用程序。Homebrew 是一个包管理器，可以方便地从终端安装、更新和卸载 macOS 应用程序和其他软件包。以下是安装应用程序的基本步骤：

在 macOS 中，您可以使用 Homebrew 这个命令行工具来安装应用程序。Homebrew 是一个包管理器，可以方便地从终端安装、更新和卸载 macOS 应用程序和其他软件包。以下是安装应用程序的基本步骤：

1.打开终端应用程序（Terminal）。
2.安装 Homebrew。输入以下命令并按回车键：
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3.等待安装完成后，输入以下命令并按回车键，以确保 Homebrew 已正确安装：
```
brew doctor
```
4.搜索要安装的应用程序。输入以下命令并按回车键：
```
brew search 应用程序名称
```
5.安装应用程序。输入以下命令并按回车键：
```
brew install 应用程序名称
```
等待安装完成后，应用程序就已安装到您的 Mac 中了。

请注意，您需要确保已经安装了 Xcode 或者 Command Line Tools，这是因为 Homebrew 需要使用它们来编译和安装软件包。如果您没有安装，系统会自动提示您安装它们。另外，您也可以使用 Homebrew Cask 来安装一些图形界面应用程序，这是 Homebrew 的另一个扩展。