/*
    # vim.ahk
    vimのコマンドを使えるようにする
*/

; -------------------------------------------------- ;

/*
    移動系コマンド
*/
; カーソル移動
sc07B & h::Send, {Blind}{left}
sc07B & j::Send, {Blind}{down}
sc07B & k::Send, {Blind}{up}
sc07B & l::Send, {Blind}{right}

; 単語移動
sc07B & w::Send, {Blind}^{right}
sc07B & b::Send, {Blind}^{left}

; Home, End
sc07B & a::
    If GetKeyState("Shift", "P")
        Send, {End}
    Return
sc07B & i::
    If GetKeyState("Shift", "P")
        Send, {Home}
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


/*
    基本的なコマンド
*/
; Undo, Redo
sc07B & u::Send, {blind}^z
sc07B & r::
    If GetKeyState(LCtrl, "P")
        Send, {blind}^+z
    Return

; Yank, Put
sc07B & y::Send, ^{c}
sc07B & p::Send, ^{v}


/*
    削除系コマンド
*/
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


/*
    選択系コマンド
*/
; 一行選択
sc07B & v::
    If GetKeyState("Shift", "P")
        Send, {Home}+{End}
    Return
