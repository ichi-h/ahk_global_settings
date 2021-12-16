/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE

    ## 注意
    レジストリでCapsLockを右Ctrl (>^) に変更しています

    ## ライセンス
    Copyright (c) 2021 ichi-h
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

; タブ移動
>^h::Send, ^+{Tab}
>^l::Send, ^{Tab}

; 左手BS
<+RCtrl::BS ; Shift + CapsLock -> BackSpace

; Alt + CapsLock -> Shift + Alt + Tab
<!RCtrl::ShiftAltTab

; 仮想デスクトップの切り替え
>^#l::Send, {Blind}#^{Right} ; Windows + CapsLock + l -> Ctrl + Win + Right
>^#h::Send, {Blind}#^{Left} ; Windows + CapsLock + h -> Ctrl + Win + Left

; 半角/全角切り替え
>^Space::Send, {sc029}

; ウィンドウを閉じる
!q::Send, !{F4} ; Alt+Q -> Alt + F4
