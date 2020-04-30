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
; Redo (Undoは複合コマンドへ)
; sc07B & r::
;     If GetKeyState(LCtrl, "P")
;         Send, {blind}^+z
;     Return

; Yank, Put
sc07B & y::Send, ^{c}
sc07B & p::Send, ^{v}



/*
    削除コマンド
*/
; 一文字削除
sc07B & x::
    If GetKeyState("Shift", "P")
        Send, {Blind}{BackSpace}
    Else
        Send, {Blind}{Delete}
    Return



/*
    選択コマンド
*/
; 一行選択
sc07B & v::
    If GetKeyState("Shift", "P")
        Send, {Home}+{End}
    Return



/*
    複合コマンド
    (一つのキーに複数のコマンドが当てられている)
*/
; 行削除, 単語削除, PgDn
sc07B & d::
    If GetKeyState("AppsKey", "P")
    {
        Send, {PgDn}
        Return
    }
    Else
    {
        Keywait, d, U
        ; Keywait, d, D T0.5
        Input, key, L1 T0.5
        If key=d
        {
            Send, {End}+{Home 2}{del 2}
            Sleep, 100
            Send, {End}
        }
        If key=w
        {
            Send, ^{Right}^+{Left}
            Sleep, 50
            Send, {BS}
        }
        Return
    }

; PgUp, Undo
sc07B & u::
    If GetKeyState("AppsKey", "P")
    {
        Send, {PgUp}
        Return
    }
    Else
    {
        Send, ^z
        Return
    }
