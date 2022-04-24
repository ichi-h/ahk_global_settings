/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

; 仮想デスクトップの切り替え
!l::Send, #^{Right} ; Windows + CapsLock + l -> Ctrl + Win + Right
!h::Send, #^{Left} ; Windows + CapsLock + h -> Ctrl + Win + Left

; ウィンドウを閉じる
!q::Send, !{F4} ; Alt+Q -> Alt + F4
