/*
    # vim.ahk
    vimのコマンドを使えるようにする
*/

; カーソル移動
sc07B & h::Send, {Blind}{left}
sc07B & j::Send, {Blind}{down}
sc07B & k::Send, {Blind}{up}
sc07B & l::Send, {Blind}{right}

; 単語移動
sc07B & w::Send, {Blind}^{right}
sc07B & b::Send, {Blind}^{left}

; Undo, Redo
sc07B & u::Send, {blind}^z
sc07B & r::
    If GetKeyState(LCtrl, "P")
        Send, {blind}^+z
    Return

; 文字削除
sc07B & x::
    If GetKeyState("Shift", "P")
        Send, {Blind}{BackSpace}
    Else
        Send, {Blind}{Delete}
    Return

; 行削除
sc07B & d::
    Keywait, d, U
    Keywait, d, D T0.5
    If ErrorLevel=0
        Send, {Blind}{End}+{Home 2}{del 2}
        Sleep, 100
        Send, {End}
    Return

; 上または下に改行して、そこにカーソル移動
sc07B & o::
    If GetKeyState("Shift", "P")
    {
        Send, {Home}
        Send, {Enter}
        Send, {up}
    }
    Else
    {
        Send, {NumpadEnd}
        Send, {Enter}
    }
    Return
    