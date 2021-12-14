/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE

    ## 参考
    - AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
    
    - (AHK)(AutoHotkey)(現在選択中のデスクトップアイコンを特定する 編) - もらかなです。
        - https://morakana.hatenadiary.org/entry/20090531/1243792116
*/

; -------------------------------------------------- ;

^+c::
    Keywait, c, U
    Input, key, L2 T0.3

    selecter = win ; win, wsl, win_backの3つ
    If key=c    ; cを二回押しでWSL、三回押しでバックスラッシュのwinのパスに変換
        selecter = wsl
    Else If key=cc
        selecter = win_back

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

        clipboard := fullpath
    }
    
    Else If WinActive("ahk_class Progman")
    {
        hBuf := DllCall("user32\FindWindow", "Str", "Progman", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SHELLDLL_DefView", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SysListView32", "UInt", 0, "UInt")

        ControlGet, FileName, List, Selected, , ahk_id %hBuf% ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := fullpath
    }

    Else If WinActive("ahk_class WorkerW")
    {
        ControlGet, FileName, List, Selected, SysListView321, ahk_class WorkerW ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := fullpath
    }

    If selecter=win
    {
        StringReplace, clipboard, clipboard, \, /, All
    }

    Else If selecter=wsl
    ; ホームディレクトリをWSL向けに変換
    {
        StringReplace, clipboard, clipboard, \, /, All

        StringLeft, drive_name_large, clipboard, 1
        StringLower, drive_name_small, drive_name_large

        win_homedir := drive_name_large . ":/"
        wsl_homedir := "/mnt/" . drive_name_small . "/"

        StringReplace, clipboard, clipboard, %win_homedir%, %wsl_homedir%, All
    }

    Else If selecter=win_back
    {
        StringReplace, clipboard, clipboard, /, \, All
    }

    return

GetSelectedFilePath(FileName)
; ファイルの情報（文字列）を加工して、絶対パスを求める
{
    FileName := RegExReplace(FileName, "\t.*$") ; tab文字以降の文字をカット

    fullpath := A_Desktop
    if FileName != 
        fullpath := fullpath . "/" . FileName
    
    return fullpath
}
