# Windows Configuration

This directory contains bootstrap and configuration files for Windows environments.

## 🎨 Terminal Themes

The `terminal-themes.json` file contains color schemes for **Windows Terminal** that match the palettes used in Ghostty and Starship (`jmacj`, `neo`, and `jetbrains`).

### How to install:

1.  Open **Windows Terminal**.
2.  Open **Settings** (Ctrl + ,).
3.  Click **Open JSON file** at the bottom left.
4.  Find the `"schemes": []` array in the JSON file.
5.  Copy the contents of `windows/terminal-themes.json` and paste them into the `schemes` array.
6.  Save the file.
7.  In the Windows Terminal settings UI, you can now select these themes for your profiles under **Appearance** > **Color scheme**.

## 🚀 Bootstrap

- `install.ps1`: Main bootstrap script for Windows.
- `packages.ps1`: Winget package list.
