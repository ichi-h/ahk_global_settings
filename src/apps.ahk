/*
    # apps.ahk
    アプリの起動
*/

; -------------------------------------------------- ;

; エクスプローラー
AppsKey & e::
    Send, #e ; CapsLock+E -> Win+E
    Send, {Blind}
    return

; 電卓（Python）
AppsKey & p::Run "C:/Users/himaz/AppData/Local/Programs/Python/Python36/python.exe"
