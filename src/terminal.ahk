/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE

    ## 注意
    レジストリでCapsLockを右Ctrl (>^) に変更しています

    ## 参考:
    1. AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
*/

; -------------------------------------------------- ;

>^c::
    sleep 50

    If WinActive("ahk_class CabinetWClass")
    ; エクスプローラーがアクティブな時
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            fullpath := ""
            try fullpath := window.Document.Folder.Self.Path
            IfWinActive, % "ahk_id " window.HWND
                break
        }
        window := ""
        
        Run wt.exe -d "%fullpath%" ; 選択中のファイルのディレクトリでwtを起動
    }

    Else If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
    ; デスクトップがアクティブな時
    {
        Run wt.exe -d "%A_Desktop%"
    }

    Else
    ; それ以外の時
    {
        Run wt.exe
    }

    return
