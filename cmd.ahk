/*
    Win+CapsLockでcmdの起動
*/

#vkF0::
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
        Run cmd, %fullpath% ; 選択中のファイルのディレクトリでcmdを起動
        window := ""

        return
    }

    Else If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
    ; デスクトップがアクティブな時
    {
        Run cmd, %A_Desktop%
        return
    }

    Else
    ; それ以外の時
    {
        Run cmd, C:\WINDOWS\system32
        return
    }
