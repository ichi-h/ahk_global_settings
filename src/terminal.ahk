/*
    # terminal.ahk
    CapsLock+CでWindows Terminal (wt) の起動

    ## 注意
    レジストリでCapsLockをAppsKeyに変更しています

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE

    ## 参考:
    1. AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
*/

; -------------------------------------------------- ;

AppsKey & c::
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
