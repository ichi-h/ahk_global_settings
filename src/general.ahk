/*
    # general.ahk
    基本的な動作のショートカット設定

    ## 注意
    レジストリでCapsLockを右Ctrl (>^) に変更しています

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

; タブ移動
>^h::Send, ^+{Tab}
>^l::Send, ^{Tab}

; 左手BS
<+RCtrl::BS ; Shift + CapsLock -> BackSpace

; Alt + CapsLock -> Shift + Alt + Tab
<!RCtrl::ShiftAltTab

; Ctrl + CapsLock -> Shift + Ctrl + Tab
<^RCtrl::Send, ^+{Tab}

; 仮想デスクトップの切り替え
; sc079::Send,#^{Right}   ; 変換 -> Ctrl + Win + Right
; +sc079::Send,#^{Left}   ; Shift+変換 -> Ctrl + Win + Left

; 半角/全角切り替え
sc079::sc029

; ウィンドウを閉じる
!q::
    Send, {Blind}
    Send, !{F4} ; Alt+Q -> Alt + F4
    return
