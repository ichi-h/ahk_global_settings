/*
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
+AppsKey::BS ; Shift + CapsLock -> BackSpace
AppsKey up::Return

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

; Enterキーを増やす
; sc07B & e::
;     Send, {Blind}
;     Send, {Enter}
;     return
