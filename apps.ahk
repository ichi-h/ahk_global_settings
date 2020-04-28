/*
    # apps.ahk
    アプリの起動
*/

; エクスプローラー
AppsKey & e::
    Send, #e ; CapsLock+E -> Win+E
    Send, {Blind}
    return

; 電卓
#c::Run C:/Windows/System32/calc.exe
