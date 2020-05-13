﻿/*
    # copy.path.ahk
    Ctrl+Shift+Cで、現在のフォルダーや選択したファイルのパスをコピーする
    （エクスプローラー、デスクトップ限定）

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE

    ## 参考
    - AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
    
    - (AHK)(AutoHotkey)(現在選択中のデスクトップアイコンを特定する 編) - もらかなです。
        - https://morakana.hatenadiary.org/entry/20090531/1243792116
*/

; -------------------------------------------------- ;

^+c::
    Keywait, c, U
    Input, key, L1 T0.3

    bool = False
    If key=c    ; cを二回押しでlinux (WSL)のパスに変換
        bool = True

    If WinActive("ahk_class CabinetWClass")
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            fullpath := ""
            for Item in window.Document.SelectedItems
                fullpath := Item.Path
            
            If fullpath = ; 変数が空の時
                try fullpath := window.Document.Folder.Self.Path
            
            IfWinActive, % "ahk_id " window.HWND
                break
        }
        window := ""

        StringReplace, fullpath, fullpath, \, /, All
        clipboard := fullpath
    }
    
    If WinActive("ahk_class Progman")
    {
        hBuf := DllCall("user32\FindWindow", "Str", "Progman", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SHELLDLL_DefView", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SysListView32", "UInt", 0, "UInt")

        ControlGet, FileName, List, Selected, , ahk_id %hBuf% ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := fullpath
    }

    If WinActive("ahk_class WorkerW")
    {
        ControlGet, FileName, List, Selected, SysListView321, ahk_class WorkerW ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := fullpath
    }

    If bool=True
        StringReplace, clipboard, clipboard, C:/Users/himaz, /mnt/c/Users/himaz, All ; ホームディレクトリをlinux向けに変換

    return

GetSelectedFilePath(FileName)
; ファイルの情報（文字列）を加工して、絶対パスを求める
{
    FileName := RegExReplace(FileName, "\t.*$") ; tab文字以降の文字をカット

    fullpath := A_Desktop
    if FileName != 
        fullpath := fullpath . "/" . FileName
    
    StringReplace, fullpath, fullpath, \, /, All ; \を/に変換
    
    return fullpath
}
