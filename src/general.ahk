﻿/*
    # general.ahk
    基本的な動作のショートカット設定

    ## 注意
    レジストリでCapsLockをAppsKeyに変更しています

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

; 左手エンター & BS
AppsKey::Enter ; CapsLock単体 -> Enter
+AppsKey::
    Send, {Blind}
    Send, {BS} ; Shift + CapsLock -> BackSpace
    return
AppsKey up::Return

; 左手Del
sc07B & AppsKey::del

; Alt + CapsLock -> Shift + Alt + Tab
<!AppsKey::ShiftAltTab

; Ctrl + CapsLock -> Shift + Ctrl + Tab
^AppsKey::
    Send, {Blind}
    Send, ^+{Tab}
    return

; 仮想デスクトップの切り替え
sc079::Send,#^{Right}   ; 変換 -> Ctrl + Win + Right
+sc079::Send,#^{Left}   ; Shift+変換 -> Ctrl + Win + Left

; ウィンドウを閉じる
!q::
    Send, {Blind}
    Send, !{F4} ; Alt+Q -> Alt + F4
    return
