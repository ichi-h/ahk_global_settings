/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE
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
    ; A => End
        Send, {End}
    Return

sc07B & i::
    If GetKeyState("Shift", "P")
    ; I => Home
        Send, {Home}
    Return

; 上または下に改行して、そこにカーソル移動
sc07B & o::
    If GetKeyState("Shift", "P")
    {
        Send, {NumpadHome}
        Send, {Enter}
        Sleep, 30
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
; Undo
sc07B & u::^z

; Redo
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
    ; V => 一行選択
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
        ; viw => 単語選択
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
    Keywait, d, U
    Input, key, L1 T0.5

    If key=d
    ; dd => 行削除
    {
        Send, {End}+{Home 2}{del 2}
        Sleep, 100
        Send, {End}
    }

    If key=i
    {
        Keywait, i, U
        Input, key, L1 T1

        If key=w
        ; diw => 単語削除
        {
            Send, ^{Right}^+{Left}
            Sleep, 50
            Send, {BS}
            Return
        }

        ; diX => Xで包まれた括弧の中身を消す
        key := Asc(key)

        clip_escape := Clipboard ; クリップボードを避難

        Send, +{Home} ; 左側を選択
        Send, ^{c}
        Sleep, 30
        Send, {BS}
        RunWait "%A_WorkingDir%\di_command\target\release\di_command.exe" "--left" "%key%"
        Send, ^{v}

        Send, +{End} ; 右側を選択
        Send, ^{c}
        Sleep, 30
        Send, {BS}
        RunWait "%A_WorkingDir%\di_command\target\release\di_command.exe" "--right" "%key%"
        Send, ^{v}

        Send, {ShiftUp}

        right_clip := RegExReplace(Clipboard, "^[\w#@$\?\[\]]{1,253}$", Replacement = "", ReplacementCount)
        str_len := StrLen(right_clip) + %ReplacementCount%
        Send, {Left %str_len%}

        Sleep, 30
        Clipboard := clip_escape ; クリップボードを復活
    }
    Return
