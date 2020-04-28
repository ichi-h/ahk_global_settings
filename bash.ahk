/*
    Win+CapsLockでGit Bashの起動

    注意:
    レジストリでCapsLockをAppsKeyに変更しています。

    参考:
    1. AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
*/

#AppsKey::
    Send, {Blind}

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
        Run C:/Program Files/Git/git-bash.exe, C:\WINDOWS\system32
        return
    }
