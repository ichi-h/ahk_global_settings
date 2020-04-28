/*
    Ctrl+Shift+Cで、現在のフォルダーや選択したファイルのパスをコピーする
    エクスプローラー、デスクトップ限定
*/

^+c::
    Send, {Blind}
    
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
        clipboard := """" . fullpath . """" ; clipboardにパスをコピー
    }
    
    If WinActive("ahk_class Progman")
    {
        hBuf := DllCall("user32\FindWindow", "Str", "Progman", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SHELLDLL_DefView", "UInt", 0, "UInt")
        hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SysListView32", "UInt", 0, "UInt")

        ControlGet, FileName, List, Selected, , ahk_id %hBuf% ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := """" . fullpath . """" ; clipboardにパスをコピー
    }

    If WinActive("ahk_class WorkerW")
    {
        ControlGet, FileName, List, Selected, SysListView321, ahk_class WorkerW ; 選択中のファイルの情報をゲット

        fullpath := GetSelectedFilePath(FileName)
        
        clipboard := """" . fullpath . """" ; clipboardにパスをコピー
    }

    return

GetSelectedFilePath(FileName)
{
    FileName := RegExReplace(FileName, "\t.*$") ; tab文字以降の文字をカット

    fullpath := A_Desktop
    if FileName != 
        fullpath := fullpath . "/" . FileName
    
    StringReplace, fullpath, fullpath, \, /, All ; \を/に変換
    
    return fullpath
}
