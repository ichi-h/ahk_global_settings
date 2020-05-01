/*
    # terminal.ahk
    CapsLock+CでGit Bashの起動

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
    sleep 250

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
        
        Run C:/Program Files/Git/git-bash.exe, %fullpath% ; 選択中のファイルのディレクトリでbashを起動

        return
    }

    Else If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
    ; デスクトップがアクティブな時
    {
        Run C:/Program Files/Git/git-bash.exe, %A_Desktop%
        return
    }

    Else
    ; それ以外の時
    {
        Run C:/Program Files/Git/git-bash.exe, C:/Program Files/Git
        return
    }
