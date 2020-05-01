/*
    # apps.ahk
    アプリの起動

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
*/

; -------------------------------------------------- ;

; エクスプローラー
AppsKey & e::
    Send, #e ; CapsLock+E -> Win+E
    Send, {Blind}
    return

; 電卓（Python）
AppsKey & p::Run "C:/Users/himaz/AppData/Local/Programs/Python/Python36/python.exe"
