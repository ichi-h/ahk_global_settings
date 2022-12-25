/*
    Copyright (c) 2021 Ichi
    本アプリは Mozilla Public License Version 2.0 の基で公開されています
    GitHub: https://github.com/ichi-h/ahk_global_settings/blob/master/LICENSE

    ## 参考
    - AutohotkeyとWindows 10：現在のエクスプローラパスを取得する方法
        - https://stackoverrun.com/ja/q/10815089
*/

; -------------------------------------------------- ;

>^F1::Run("%A_MyDocuments%/cheat_sheet/command.txt")
>^F2::Run("%A_MyDocuments%/cheat_sheet/english.txt")
#t::Run("wt.exe")
