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

; ページの先頭・最後へ
sc07B & g::
    If GetKeyState("Shift", "P")
    {
        Send, ^{End}
        Return
    }
    
    Keywait, g, U
    Keywait, g, D T0.5

    If ErrorLevel=0
    {
        Send, ^{Home}
        Return
    }

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
sc07B & v::
    If GetKeyState("Shift", "P")
    ; 一行選択
    {
        Send, {Home}+{End}
        Return
    }
    
    Keywait, v, U
    Input, key, L1 T0.5

    If key=i
    {
        Keywait, i, U
        Input, key, L1 T0.5

        If key=w
        ; 単語選択
        {
            Send, ^{Left}
            Send, ^+{Right}
        }
        Return
    }
    Return



/*
    複合コマンド
    (一つのキーに複数のコマンドが当てられている)
*/
sc07B & d::
    If GetKeyState("AppsKey", "P")
    ; PgDn
    {
        Send, {PgDn}
        Return
    }

    Else
    {
        Keywait, d, U
        Input, key, L1 T0.5

        If key=d
        ; 行削除
        {
            Send, {End}+{Home 2}{del 2}
            Sleep, 100
            Send, {End}
        }

        If key=w
        ; 単語削除
        {
            Send, ^{Right}^+{Left}
            Sleep, 50
            Send, {BS}
        }

        If key=i
        ; 括弧の中身を消す
        {
            Keywait, i, U
            Input, key, L1 T1
            key := Asc(key)

            Send, +{Home}
            Send, ^{c}
            Sleep, 30
            before_left_clip := RegExReplace(Clipboard, "^[\w#@$\?\[\]]{1,253}$", Replacement = "a")

            Send, {End}+{Home}
            Send, ^{c}
            Sleep, 30
            before_str_len := StrLen(before_left_clip)

            RunWait "%A_WorkingDir%\di_command\target\release\di_command.exe" "%Clipboard%" "%key%" "%before_left_clip%"
            
            Send, ^{v}
            Send, {Home}
            Send, {Right %before_str_len%}
        }
        Return
    }

sc07B & u::
    If GetKeyState("AppsKey", "P")
    ; PgUp
    {
        Send, {PgUp}
        Return
    }
    Else
    ; Undo
    {
        Send, ^z
        Return
    }
