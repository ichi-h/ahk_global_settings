/*
    # main.ahk
    設定した.ahkをIncludeし、実行

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,2

#SingleInstance force
#InstallKeybdHook
#UseHook

#Include general.ahk
#Include apps.ahk
#Include copy_path.ahk
#Include terminal.ahk
#Include vim.ahk
