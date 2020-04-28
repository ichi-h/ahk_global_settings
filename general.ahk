/*
    基本的な動作のショートカット設定

    注意:
    レジストリでCapsLockをAppsKeyに変更しています。
*/

; キー無効化
AppsKey::Return ; CapsLock単体の使用を無効にする

; ウィンドウを閉じる
!q::
    Send, {Blind}
    Send, !{F4} ; Alt+Q -> Alt + F4
    return

; 仮想デスクトップの切り替え
sc07B::Send,#^{Left}   ; 変換 -> Ctrl+Win+Left
sc079::Send,#^{Right}  ; 無変換 -> Ctrl+Win+Right
