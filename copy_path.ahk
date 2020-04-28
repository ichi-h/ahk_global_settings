/*
    Ctrl+Shift+Cで、現在のフォルダーや選択したファイルのパスをコピーする（エクスプローラー限定）
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
        clipboard := """" . fullpath . """"
    }
    
    ; If WinActive("ahk_class Progman")
    ; {
    ;     hBuf := DllCall("user32\FindWindow", "Str", "Progman", "UInt", 0, "UInt")
    ;     hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SHELLDLL_DefView", "UInt", 0, "UInt")
    ;     hBuf := DllCall("user32\FindWindowEx", "UInt", hBuf, "UInt", 0, "Str", "SysListView32", "UInt", 0, "UInt")

    ;     ControlGet, SelFN, List, Selected, , ahk_id %hBuf%
    ;     Clipboard := SelFN
    ;     MsgBox % SelFN
    ; }

    ; If WinActive("ahk_class WorkerW")
    ; {
    ;     ControlGet, SelFN, List, Selected, SysListView321, ahk_class WorkerW
    ;     Clipboard := SelFN
    ;     MsgBox % SelFN
    ; }

    return

