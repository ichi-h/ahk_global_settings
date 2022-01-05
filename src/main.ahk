/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE
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

#Include %A_ScriptDir%

#Include general.ahk
#Include apps.ahk
#Include copy_path.ahk
#Include vim.ahk
