/*
    Win+CapsLockでcmdの起動
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
        Run C:/Program Files/Git/git-bash.exe, %fullpath% ; 選択中のファイルのディレクトリでcmdを起動
        window := ""

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
