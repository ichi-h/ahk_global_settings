/*
    基本的な動作のショートカット設定
*/

; キー無効化
vkF0::Return ; CapsLock単体の使用を無効にする

; エクスプローラーの起動
; vkF0 & e::#e ; CapsLock+E -> Win+E

; ウィンドウを閉じる
!q::!F4 ; Alt+Q -> Alt + F4

; 仮想デスクトップの遷移
sc07B::Send,#^{Left}   ; 変換 -> Ctrl+Win+Left
sc079::Send,#^{Right}  ; 無変換 -> Ctrl+Win+Right
